class ChartManager {
    constructor(canvasId, chartType = 'doughnut') {
        this.canvasId = canvasId;
        this.chartType = chartType;
        this.chart = null;  // Chart.js 인스턴스
    }
    
    async fetchDatas() {
        try {
            const response = await fetch('/doughnutchart.chartdata');
            return await response.json();
        } catch (error) {
            console.error("Error fetching data:", error);
            return [];
        }
    }

    // 차트 데이터 설정 (doughnut 차트용 backgroundColor 수정)
    async getChartData() {
        const datas = await this.fetchDatas();
        return {
            labels: ['10대', '20대', '30대', '40대', '50대'],
            datasets: [
                {
                    label: '명',
                    data: datas,
                    borderColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF'],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.6)', 'rgba(54, 162, 235, 0.6)',
                        'rgba(255, 206, 86, 0.6)', 'rgba(75, 192, 192, 0.6)',
                        'rgba(153, 102, 255, 0.6)'
                    ],
                    borderWidth: 1
                }
            ]
        };
    }

    // 차트 옵션 설정 (반응형, 애니메이션 추가)
    getChartOptions() {
        return {
            responsive: true,
            maintainAspectRatio: false,
            animation: {
                duration: 2000,
                easing: 'easeOutQuart'
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        };
    }

    // 차트 생성 메서드 (중복 차트 제거 기능 추가)
    async createChart() {
        let canvas = document.getElementById(this.canvasId);
        let ctx = canvas.getContext('2d');
        
        if (this.chart) {
            this.chart.destroy();
        }
        
        try {
            const data = await this.getChartData();
            this.chart = new Chart(ctx, {
                type: this.chartType,
                data: data,
                options: this.getChartOptions()
            });
        } catch (error) {
            console.error('Error creating chart:', error);
        }
    }
}

// 모듈 내보내기 (ES6 방식)
export default ChartManager;
