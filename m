Return-Path: <linux-erofs+bounces-463-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9238BADE0D4
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Jun 2025 03:47:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMRS96G7Jz30Ql;
	Wed, 18 Jun 2025 11:47:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750211225;
	cv=none; b=nyLYqcFr2EjrS3S37ulyZ7MH/AkXCtjTdpNJVSJHlLEmhmvld5bbhk4yzSEv+3t2Gzx8MHuuw8v+LY6r5vlQZnC7BtDqCucxBWsFL/XBXrdypTuORQI74pjh6x2LrKnTYi9ghrgT/ojKj0M30np5d/obNaGPcM6Gz6v2wxMV/SfxvUIBYZu7VUiclEaZP5cq90tYzSG3MTpBH1hAkjzYCvFJJ2e/5Hf4+mh+4qaRt8n7ORX1Rm9WsjlWbHTKaig7bBSLHxr5tvZAmPfne0MZvoXYwLgqPdkbLBqOw54DNIhUOwYl4XNeXCa8SflYVVkTVTeF/vnfaoY5u6mQCOlw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750211225; c=relaxed/relaxed;
	bh=OMoJrP9BCHauADjVK3o4tsNsoLOEZwFzXb6T9fnNTqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TKfmGU/degqmNpGRc5X4HraUNOave3PKzLtjqBFNXVQSbp+zldJpUgW1WmuDUdW14/98MQxgPaVEEV8MMdxWfEuM366NRpi1zCTbdtB/PeMEMSi6As3OpiFZcdF0GMaEEv4r/ieea9kBwlaI7d9IF9z3WIS8MC2tr0I/zZhqXayGSXTN3d1eUn7XvSBe8x7hsk275aUn1OqNTJkKTsOTwbYtG8NbjlYZ49q2MG92PefPlNkzmV1kDWFtcWEn+5KlkjMwq+vrn0TRNpTKMGfvIGdI0NSXCKqdo08Yu+fKZdO1nq8W378/OO9IUWeRXiJaNZaKbmYaoNVaJEiYfFlC+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMRS64MKfz2yb9
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Jun 2025 11:47:00 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bMRPC1mJKz1W3TX;
	Wed, 18 Jun 2025 09:44:31 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id CC1B018005F;
	Wed, 18 Jun 2025 09:46:55 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 09:46:55 +0800
Message-ID: <68eb3c3b-b67c-46e7-a6a5-044d4415e2b7@huawei.com>
Date: Wed, 18 Jun 2025 09:46:53 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: impersonate the opener's credentials when
 accessing backing file
To: Tatsuyuki Ishi <ishitatsuyuki@google.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
	<jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<shengyong1@xiaomi.com>, <wangshuai12@xiaomi.com>
References: <20250612-b4-erofs-impersonate-v1-1-8ea7d6f65171@google.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250612-b4-erofs-impersonate-v1-1-8ea7d6f65171@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/6/12 18:18, Tatsuyuki Ishi wrote:
> Previously, file operations on a file-backed mount used the current
> process' credentials to access the backing FD. Attempting to do so on
> Android lead to SELinux denials, as ACL rules on the backing file (e.g.
> /system/apex/foo.apex) is restricted to a small set of process.
> Arguably, this error is redundant and leaking implementation details, as
> access to files on a mount is already ACL'ed by path.
> 
> Instead, override to use the opener's cred when accessing the backing
> file. This makes the behavior similar to a loop-backed mount, which
> uses kworker cred when accessing the backing file and does not cause
> SELinux denials.
> 
> Signed-off-by: Tatsuyuki Ishi <ishitatsuyuki@google.com>
> ---
>   fs/erofs/fileio.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 7d81f504bff08f3d5c5d44d131460df5c3e7847d..df5cc63f2c01eb5e7ec4afab9e054ea12cea7175 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -47,6 +47,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   
>   static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>   {
> +	const struct cred *old_cred;
>   	struct iov_iter iter;
>   	int ret;
>   
> @@ -60,7 +61,9 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>   		rq->iocb.ki_flags = IOCB_DIRECT;
>   	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
>   		      rq->bio.bi_iter.bi_size);
> +	old_cred = override_creds(rq->iocb.ki_filp->f_cred);Yeah, rq->iocb.ki_filp keep the opener's cred, so:

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

>   	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
> +	revert_creds(old_cred);
>   	if (ret != -EIOCBQUEUED)
>   		erofs_fileio_ki_complete(&rq->iocb, ret);
>   }
> 
> ---
> base-commit: cd2e103d57e5615f9bb027d772f93b9efd567224
> change-id: 20250612-b4-erofs-impersonate-d6c2926c56ca
> 
> Best regards,

