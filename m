Return-Path: <linux-erofs+bounces-131-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F40A75DDF
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 04:38:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQwL13s2Vz2yf1;
	Mon, 31 Mar 2025 13:38:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743388713;
	cv=none; b=foHs1o0YJV9ZEupsd9bct3QkgIuN58dKM0cHf2SHxXbnaErgcAlfSg/ntLSlXPNLb2xkx/89SPpPDb3DByyaJc13Y++zgM+UdRhdu+lIWBjsR3cssR0NVD1bLUppPdV8nU9HOZUtIh3j9h6sDnxIjXIEzqO7peIeAF0XRozd9eU6RXvqhRy2K3d/4KDB/oHj1GDb3MRm0+7xsdsSIVoWuOIHShnU4zcNpKgNjnGbPmMOAXUhiasB+sk10UvwcUnzRUARKDxBFWP0TdR/tdSQD9AvQsJAoBbbtcFaJmIluuKEGUj6+96hyPtIIge6rRV0UmYC5vQ/iGJwCgsoyPSC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743388713; c=relaxed/relaxed;
	bh=m+t0zh/r59QNdGb12b76vwfxj7WeH46XCXDtQa2X+p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYYt1x10uRaJnfGdUFGFFie/VK3bcQ4w87RnIZV3iHGCt8q1O2RA9mL9s5C0Y2KC1U7axkJYz3KzfiixlFktvdL5jgCnofLP1Gj0EKX8PIT2itzVuoOpxSCrY6Y4/zKkLWzgq0nUE/Xf0s+YMXF2t7THPvJhdXnrsRCd6JKVPjkYza7UXXDzKqg0J70zfWkBS3OV+mCh04sPUBmq8rcvzXjuFxSfJo2vRo5bTEPis4qtcVMPYeo80yEuA2o/cB0FaFhSGBEMMR/px6wGieLzbTH8XbHqM74orPc0ieGkHGV+0FQIRJdBK/3dW+Ng+nWrWiwvOqz1JZvGJ3gNcgRMnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Bzr9bhkF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Bzr9bhkF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQwKy55Pjz2yFP
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 13:38:28 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743388704; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=m+t0zh/r59QNdGb12b76vwfxj7WeH46XCXDtQa2X+p4=;
	b=Bzr9bhkFR3mzymvpGLFkXTG/wEjjyguVJNCAurjU+Ng7qxGjg7YNNQE9ffry4m0yrFuKcpyA3+lV2F2UHxzL6iN2bqSYTJAoQ9nrCv3tH/NW850XeCqa/kBFKq2KjmtCe1dWes8AOL9DR6u5Q3Pk+xIeyWrh0CGi21N1F29OMl4=
Received: from 30.221.130.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WTOlX-D_1743388702 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Mar 2025 10:38:22 +0800
Message-ID: <45548d9e-4cfa-476d-9eaa-b338f994478c@linux.alibaba.com>
Date: Mon, 31 Mar 2025 10:38:21 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20250331022011.645533-1-dhavale@google.com>
 <20250331022011.645533-2-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250331022011.645533-2-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Sandeep,

On 2025/3/31 10:20, Sandeep Dhavale wrote:
> Defer initialization of per-CPU workers and registration for CPU hotplug
> events until the first mount. Similarly, unregister from hotplug events
> and destroy per-CPU workers when the last mount is unmounted.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> ---
>   fs/erofs/internal.h |  5 +++++
>   fs/erofs/super.c    | 27 +++++++++++++++++++++++++++
>   fs/erofs/zdata.c    | 35 +++++++++++++++++++++++------------
>   3 files changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ac188d5d894..c88cba4da3eb 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -450,6 +450,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages);
>   int __init z_erofs_gbuf_init(void);
>   void z_erofs_gbuf_exit(void);
>   int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
> +int z_erofs_init_workers(void);
> +void z_erofs_destroy_workers(void);
>   #else
>   static inline void erofs_shrinker_register(struct super_block *sb) {}
>   static inline void erofs_shrinker_unregister(struct super_block *sb) {}
> @@ -458,6 +460,9 @@ static inline void erofs_exit_shrinker(void) {}
>   static inline int z_erofs_init_subsystem(void) { return 0; }
>   static inline void z_erofs_exit_subsystem(void) {}
>   static inline int z_erofs_init_super(struct super_block *sb) { return 0; }
> +static inline int z_erofs_init_workers(void) { return 0; };
> +static inline  z_erofs_exit_workers(void);
> +
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
>   #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index cadec6b1b554..8e8d3a7c8dba 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -17,6 +17,7 @@
>   #include <trace/events/erofs.h>
>   
>   static struct kmem_cache *erofs_inode_cachep __read_mostly;
> +static atomic_t erofs_mount_count = ATOMIC_INIT(0);
>   
>   void _erofs_printk(struct super_block *sb, const char *fmt, ...)
>   {
> @@ -777,9 +778,28 @@ static const struct fs_context_operations erofs_context_ops = {
>   	.free		= erofs_fc_free,
>   };
>   
> +static inline int erofs_init_zip_workers_if_needed(void)
> +{
> +	int ret;
> +
> +	if (atomic_inc_return(&erofs_mount_count) == 1) {
> +		ret = z_erofs_init_workers();
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static inline void erofs_destroy_zip_workers_if_last(void)

Do we really need to destroy workers on the last mount?
it could cause many unnecessary init/uninit cycles.

Or your requirement is just to defer per-CPU workers to
the first mount?

If your case is the latter, I guess you could just call
erofs_init_percpu_workers() in z_erofs_init_super().

> +{
> +	if (atomic_dec_and_test(&erofs_mount_count))

So in that case, we won't need erofs_mount_count anymore,
you could just add a pcpu_worker_initialized atomic bool
to control that.

Thanks,
Gao Xiang

