<template>
    <div>
        <div class="form-group">
            <label for="cron-time">Cron time (minute)</label>
            <input type="text" class="form-control" id="cron-time" aria-describedby="cron-time" placeholder="Cron time" v-model="settings">
        </div>
        <button v-on:click="editSettings" class="btn btn-primary">Update</button>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                has_error: false,
                settings: null
            }
        },

        mounted() {
            this.getSettings()
        },

        methods: {
            getSettings() {
                this.$http({
                    url: `settings_list`,
                    method: 'GET'
                })
                    .then((res) => {
                        this.settings = res.data.settings[0].value;
                        console.log();
                    }, () => {
                        this.has_error = true
                    })
            },
            editSettings(){
                let data;
                data = 'cron_time=';
                data += $("#cron-time").val();
                this.$http({
                    url: `settings_list`,
                    method: 'POST',
                    data : data
                })
                    .then((res) => {
                        // this.getSettings()
                    }, () => {
                        this.has_error = true
                    })
            },
        }
    }
</script>
