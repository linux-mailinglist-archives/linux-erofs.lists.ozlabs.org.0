Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34F15D0D8
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2020 05:04:31 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Jfs80dQVzDqXd
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2020 15:04:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=hisilicon.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=wangzhou1@hisilicon.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=hisilicon.com
X-Greylist: delayed 971 seconds by postgrey-1.36 at bilbo;
 Fri, 14 Feb 2020 15:04:15 AEDT
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Jfrv1wRPzDqX9
 for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2020 15:04:09 +1100 (AEDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C36B0383C2D9BD887B39;
 Fri, 14 Feb 2020 11:47:50 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Feb 2020
 11:47:47 +0800
Subject: Re: [PATCH] Remove WQ_CPU_INTENSIVE flag from unbound wq's
To: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 <dm-devel@redhat.com>, Song Liu <song@kernel.org>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-raid@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>
References: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E461863.3000004@hisilicon.com>
Date: Fri, 14 Feb 2020 11:47:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/2/13 22:18, Maksym Planeta wrote:
> The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
> unbound wq. I remove this flag from places where unbound queue is
> allocated. This is supposed to improve code readability.
> 
> 1. https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
> 
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
> ---
>  drivers/crypto/hisilicon/qm.c | 3 +--
>  drivers/md/dm-crypt.c         | 2 +-
>  drivers/md/dm-verity-target.c | 2 +-
>  drivers/md/raid5.c            | 2 +-
>  fs/erofs/zdata.c              | 2 +-
>  5 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index b57da5ef8b5b..4a39cb2c6a0b 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -1148,8 +1148,7 @@ struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type)
>  	qp->qp_id = qp_id;
>  	qp->alg_type = alg_type;
>  	INIT_WORK(&qp->work, qm_qp_work_func);
> -	qp->wq = alloc_workqueue("hisi_qm", WQ_UNBOUND | WQ_HIGHPRI |
> -				 WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0);
> +	qp->wq = alloc_workqueue("hisi_qm", WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);

I am OK with qm code.

Thanks!
Zhou

>  	if (!qp->wq) {
>  		ret = -EFAULT;
>  		goto err_free_qp_mem;
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index c6a529873d0f..44d56325fa27 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -3032,7 +3032,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  						  1, devname);
>  	else
>  		cc->crypt_queue = alloc_workqueue("kcryptd/%s",
> -						  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND,
> +						  WQ_MEM_RECLAIM | WQ_UNBOUND,
>  						  num_online_cpus(), devname);
>  	if (!cc->crypt_queue) {
>  		ti->error = "Couldn't create kcryptd queue";
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 0d61e9c67986..20f92c7ea07e 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -1190,7 +1190,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  	}
>  
>  	/* WQ_UNBOUND greatly improves performance when running on ramdisk */
> -	v->verify_wq = alloc_workqueue("kverityd", WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND, num_online_cpus());
> +	v->verify_wq = alloc_workqueue("kverityd", WQ_MEM_RECLAIM | WQ_UNBOUND, num_online_cpus());
>  	if (!v->verify_wq) {
>  		ti->error = "Cannot allocate workqueue";
>  		r = -ENOMEM;
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index ba00e9877f02..cd93a1731b82 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -8481,7 +8481,7 @@ static int __init raid5_init(void)
>  	int ret;
>  
>  	raid5_wq = alloc_workqueue("raid5wq",
> -		WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE|WQ_SYSFS, 0);
> +		WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_SYSFS, 0);
>  	if (!raid5_wq)
>  		return -ENOMEM;
>  
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 80e47f07d946..b2a679f720e9 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -43,7 +43,7 @@ void z_erofs_exit_zip_subsystem(void)
>  static inline int z_erofs_init_workqueue(void)
>  {
>  	const unsigned int onlinecpus = num_possible_cpus();
> -	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
> +	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI;
>  
>  	/*
>  	 * no need to spawn too many threads, limiting threads could minimum
> 

