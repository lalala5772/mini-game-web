<<<<<<< HEAD
// ChartManager.js
class ChartManager {
    constructor(canvasId, chartType = 'line') {
        this.canvasId = canvasId;
        this.chartType = chartType;
        this.chart = null;  // Chart.js 인스턴스
    }

    // 📌 차트 데이터 설정
    getChartData() {
        return {
            labels: ['1월', '2월', '3월', '4월', '5월'],
            datasets: [
                {
                    label: '신규 회원수',
                    data: [10, 20, 15, 30, 40],
                    borderColor: 'blue',
                    backgroundColor: 'rgba(0, 0, 255, 0.2)',
                    borderWidth: 2
                }
            ]
        };
    }

    // 📌 차트 옵션 설정
    getChartOptions() {
        return {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        };
    }

    // 📌 차트 생성 메서드
    createChart() {
        let ctx = document.getElementById(this.canvasId);
        if (ctx) {
            ctx = ctx.getContext('2d');
            this.chart = new Chart(ctx, {
                type: this.chartType,
                data: this.getChartData(),
                options: this.getChartOptions()
            });
        } else {
            console.error(`Canvas 요소 #${this.canvasId} 를 찾을 수 없습니다.`);
        }
    }
}

// 모듈 내보내기 (ES6 방식)
export default ChartManager;
=======
class ChartManager {
    constructor(canvasId, chartType = 'line') {
        this.canvasId = canvasId;
        this.chartType = chartType;
        this.chart = null;  // Chart.js 인스턴스
    }

    async fetchLabels() {
        try {
            const response = await fetch('/chartdatecontroller'); // 자바 서블릿 API 호출
            return await response.json();
        } catch (error) {
            console.error("❌ Error fetching labels:", error);
            return [];
        }
    }

    async fetchDatas() {
        try {
            const response = await fetch('/linechart.chartdata');
            return await response.json();
        } catch (error) {
            console.error("❌ Error fetching data:", error);
            return [];
        }
    }

    // 차트 데이터 설정
    async getChartData() {
        const labels = await this.fetchLabels();
        const datas = await this.fetchDatas();
        return {
            labels: labels,
            datasets: [
                {
                    label: '신규 회원수',
                    data: datas,
                    borderColor: 'blue',
                    backgroundColor: 'rgba(0, 0, 255, 0.2)',
                    borderWidth: 2
                }
            ]
        };
    }

    // 차트 옵션 설정
    getChartOptions() {
        return {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        };
    }

    // 차트 생성 메서드
    async createChart() {
        let canvas = document.getElementById(this.canvasId);
        let ctx = canvas.getContext('2d'); // getContext 호출 위치 조정
        
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
            console.error('❌ Error creating chart:', error);
        }
    }
}

// 모듈 내보내기 (ES6 방식)
export default ChartManager;
>>>>>>> 04eb06352e5479665d0011f90eaba7aef9a585d3
