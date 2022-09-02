Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3C5AA742
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 07:33:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJmlX3DDcz2yx8
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 15:32:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TLwLBT3u;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TLwLBT3u;
	dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJmlM6mbLz2xn3
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 15:32:45 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id u22so796607plq.12
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Sep 2022 22:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rtJH7HDl3ZtKSbrfLkxuA1N38k7LaCGirWVFNaiJ6R4=;
        b=TLwLBT3uGdA+Z8T75wH08Ri404/Qtg9nbBpojuvigEs/I6m+/vOfLlNUIgvcRUBjRv
         xd6pyeC7pZ6K8jP0tKu5XOaQyLEbfQloPxspX2b9PfO9SIjOU1sivZWKVF7rnSRuSl9b
         bsw8pLIE7OOrugLZKK8J9CITZGlXOSRaYFuR/SLF+tlyrH1VXZe6JBilcXxI/QVTjPHD
         fQ/dl4U2C9yX50CJblBIui6sH4rnbfwv6JW7KIHetG2tznuC4NjAlgf3YcRX3o4VoW/R
         /jgz87ZWiY/Bij45zvdDUNSoWzFwBqVIGWEL4Ox2xosW4+Es7WQvOvqPRYev7IYT7xzs
         6PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rtJH7HDl3ZtKSbrfLkxuA1N38k7LaCGirWVFNaiJ6R4=;
        b=AH7PKV/GiTTMGt+1XHxcGXN8wY8BTrgF62SO//EJuLv04O5XD/qvLPR+1LPbA8vEIv
         fHLm+STl3XrTZnFuNDoaDIFv2BnQtJ524fLaltWOOIwRccRLlLsdlvNSOP6gCU4P9q24
         T4dYk1kLhkiPjkOT9tnHAiYKN0vfTtM/h1vzdCTpRDJ3lXf19L4lTcCiTMjAcajv5227
         tA1oMerQ33N/sotkQvJKQlgEF0SPBOw4ybW3u0MhzU0Zz4Qk8h51dZr8lZfjUBMKOKTr
         NQ9k62v5b3e5bsIw6qysA1Ub8/riiCGEw5fcEymdH36+EhSyofK4mNqWkFifsCPRy0e0
         Wqew==
X-Gm-Message-State: ACgBeo3CBpAByyGjuBy++9rPwoLEmqoBLgOYERd0aEBVCExDbUeDq5U9
	ilJyrMXtthmySdVag59aJI4=
X-Google-Smtp-Source: AA6agR5DZqKe/pZ3wQTonj7mZ/5CX3roXnOiggq9KM6jHI+wC94769cob0GqyU6YD6/oXyMK+1z/rQ==
X-Received: by 2002:a17:90b:4ac3:b0:1fd:ded0:ea80 with SMTP id mh3-20020a17090b4ac300b001fdded0ea80mr2926310pjb.142.1662096762577;
        Thu, 01 Sep 2022 22:32:42 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b24-20020a630c18000000b0042a5e8486a1sm513142pgl.42.2022.09.01.22.32.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Sep 2022 22:32:42 -0700 (PDT)
Date: Fri, 2 Sep 2022 13:34:58 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix pcluster use-after-free on UP platforms
Message-ID: <20220902133458.000008b0.zbestahu@gmail.com>
In-Reply-To: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
References: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  2 Sep 2022 12:57:10 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> During stress testing with CONFIG_SMP disabled, KASAN reports as below:
> 
> ==================================================================
> BUG: KASAN: use-after-free in __mutex_lock+0xe5/0xc30
> Read of size 8 at addr ffff8881094223f8 by task stress/7789
> [ 3482.258885]
> CPU: 0 PID: 7789 Comm: stress Not tainted 6.0.0-rc1-00002-g0d53d2e882f9 #3
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> Call Trace:
>  <TASK>
> ..
>  __mutex_lock+0xe5/0xc30
> ..
>  z_erofs_do_read_page+0x8ce/0x1560
> ..
>  z_erofs_readahead+0x31c/0x580
> ..
> Freed by task 7787
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x20/0x30
>  kasan_set_free_info+0x20/0x40
>  __kasan_slab_free+0x10c/0x190
>  kmem_cache_free+0xed/0x380
>  rcu_core+0x3d5/0xc90
>  __do_softirq+0x12d/0x389
> [ 3482.295630]
> Last potentially related work creation:
>  kasan_save_stack+0x1e/0x40
>  __kasan_record_aux_stack+0x97/0xb0
>  call_rcu+0x3d/0x3f0
>  erofs_shrink_workstation+0x11f/0x210
>  erofs_shrink_scan+0xdc/0x170
>  shrink_slab.constprop.0+0x296/0x530
>  drop_slab+0x1c/0x70
>  drop_caches_sysctl_handler+0x70/0x80
>  proc_sys_call_handler+0x20a/0x2f0
>  vfs_write+0x555/0x6c0
>  ksys_write+0xbe/0x160
>  do_syscall_64+0x3b/0x90
> 
> The root cause is that erofs_workgroup_unfreeze() doesn't reset
> to orig_val thus it causes a race that the pcluster reuses unexpectedly
> before freeing.
> 
> Since UP platforms are quite rare now, such path becomes unnecessary.
> Let's drop such specific-designed path directly instead.
> 
> Fixes: 73f5c66df3e2 ("staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/internal.h | 29 -----------------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index cfee49d33b95..a01cc82795a2 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -195,7 +195,6 @@ struct erofs_workgroup {
>  	atomic_t refcount;
>  };
>  
> -#if defined(CONFIG_SMP)
>  static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
>  						 int val)
>  {
> @@ -224,34 +223,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>  	return atomic_cond_read_relaxed(&grp->refcount,
>  					VAL != EROFS_LOCKED_MAGIC);
>  }
> -#else
> -static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
> -						 int val)
> -{
> -	preempt_disable();
> -	/* no need to spin on UP platforms, let's just disable preemption. */
> -	if (val != atomic_read(&grp->refcount)) {
> -		preempt_enable();
> -		return false;
> -	}
> -	return true;
> -}
> -
> -static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
> -					    int orig_val)
> -{
> -	preempt_enable();
> -}
> -
> -static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
> -{
> -	int v = atomic_read(&grp->refcount);
> -
> -	/* workgroup is never freezed on uniprocessor systems */
> -	DBG_BUGON(v == EROFS_LOCKED_MAGIC);
> -	return v;
> -}
> -#endif	/* !CONFIG_SMP */
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  

Reviewed-by: Yue Hu <huyue2@coolpad.com>

>  /* we strictly follow PAGE_SIZE and no buffer head yet */

