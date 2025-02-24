<<<<<<< HEAD
// ChartManager.js
class ChartManager {
    constructor(canvasId, chartType = 'doughnut') {
        this.canvasId = canvasId;
        this.chartType = chartType;
        this.chart = null;  // Chart.js 인스턴스
    }

    // 📌 차트 데이터 설정 (doughnut 차트용 backgroundColor 수정)
    getChartData() {
        return {
            labels: ['10대', '20대', '30대', '40대', '50대'],
            datasets: [
                {
                    label: '매출 (단위: 만원)',
                    data: [10, 20, 15, 30, 40],
                    borderColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF'], // pie 차트용
                    backgroundColor: ['rgba(255, 99, 132, 0.6)', 'rgba(54, 162, 235, 0.6)', 
                                      'rgba(255, 206, 86, 0.6)', 'rgba(75, 192, 192, 0.6)', 
                                      'rgba(153, 102, 255, 0.6)'], // pie 차트 배경색
                    borderWidth: 1
                }
            ]
        };
    }

    // 📌 차트 옵션 설정 (반응형, 애니메이션 추가)
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

    // 📌 차트 생성 메서드 (중복 차트 제거 기능 추가)
    createChart() {
        let canvas = document.getElementById(this.canvasId);
        if (canvas) {
            let ctx = canvas.getContext('2d');

            // 기존 차트 삭제 (중복 방지)
            if (this.chart) {
                this.chart.destroy();
            }

            // 새 차트 생성
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
>>>>>>> 04eb06352e5479665d0011f90eaba7aef9a585d3
