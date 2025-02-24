class ChartManager {
    constructor(canvasId, chartType = 'bar') {
        this.canvasId = canvasId;
        this.chartType = chartType;
        this.chart = null; // Chart.js 인스턴스
    }

    async fetchDatas() {
        try {
            const response = await fetch('/barchart.chartdata');
            return await response.json();
        } catch (error) {
            console.error("Error fetching labels:", error);
            return [];
        }
    }

    // 차트 데이터 설정 (bar 차트용 색상 추가)
    async getChartData() {
        const datas = await this.fetchDatas();
        return {
            labels: ["Barbecue_Game", "Rythme_Game", "Zombie_Crusher", "스네이크 게임", "크로스 로드", "참참참!"],
            datasets: [
                {
                    label: "플레이횟수",
                    data: datas,
                    borderColor: "rgba(75, 192, 192, 1)",
                    backgroundColor: "rgba(75, 192, 192, 0.2)",
                    borderWidth: 1
                }
            ]
        };
    }

    // 차트 옵션 설정 (반응형, 애니메이션 추가)
    getChartOptions() {
        return {
            responsive: true,
            maintainAspectRatio: false, // 가로/세로 비율 유지 X
            animation: {
                duration: 2000, // 2초 동안 애니메이션 실행
                easing: 'easeOutQuart' // 자연스럽게 시작 -> 부드럽게 끝남
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        };
    }

    // 차트 생성 메서드 (중복 차트 제거)
    async createChart() {
        const canvas = document.getElementById(this.canvasId);
        const ctx = canvas.getContext('2d');

        if (this.chart) {
            this.chart.destroy();
        }

        try {
            const datas = await this.getChartData();
            // 새 차트 생성
            this.chart = new Chart(ctx, {
                type: this.chartType,
                data: datas,
                options: this.getChartOptions()
            });
        } catch (error) {
            console.error('Error creating chart:', error);
        }
    }
}

export default ChartManager;
