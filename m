Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BADD6D1730
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 08:17:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PnqpN0mrCz3f7F
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 17:17:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=aIAo7trA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=aIAo7trA;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PnqpJ4SZrz3cMy
	for <linux-erofs@lists.ozlabs.org>; Fri, 31 Mar 2023 17:17:43 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so24408616pjp.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680243461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0wmzkuX4AN1JDHvFbUNTXSHQNONwj8XqGOw+tG4o8w=;
        b=aIAo7trAO5Z0jzs18Ea+faRyv7OXzGrSdUtTgXpTZct2tJU2RcNLuX5v47FqLoqRNF
         JEXO6LTM9XEMb/Y4Udbl9EFwKeD2bzDgQi+164YD8Qc4psuP2Nx9KK08/qsDo6HdwJyj
         JYYj1mUnXts23tSlAs1hhiXWKJVm8HVc/MPRctwQ+MUwwFEg/ImtVMEZm8FpMNjt3bZg
         EPQ6ZK0Tm209Z+JCigsuyhvv8X5s1MJ15YZA1NZCuzg4tK9N4EWJl6aaWmMQay6/KE4B
         pCZmszIgOsVkreFqOVqSgGXKvAqcwXKEi5P5FnYVa0lfs9Vhy7FzFfPEWOdXzYX3qY/k
         DSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680243461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0wmzkuX4AN1JDHvFbUNTXSHQNONwj8XqGOw+tG4o8w=;
        b=F+kI5PD5wARB+S5tU0epbY68MJG+qKbj4zHx2s9UAqpfnpPMNFKiOcIE5NVRkFMX07
         CxJu8hUnvQQeM0jk+3kUT5RtdvSn0OtRC+ahqxgve/xaZx9GUObruiQ+ifQpO5+d3/zM
         6BO7HWxldqCGQ3v3wdSXpC6M5T/ibyHjfTZ48Qv5zeW9EdCWGYAOv8NG/rHQnFat/EHp
         frVeAaJgK5QsokebR5XSsduJyeesSkmpiflSsprFK46KQzLBzUzN+Oedd6nZk2KdI3mm
         0mnSKYaw64lrY38jZdcxiGBfZKfdkwj7Sn3ksGMmNt8RSHA1TAa9pTkiPBdGOPezhhbx
         Juyg==
X-Gm-Message-State: AAQBX9cp/lVf8h1J6rvOypnRMSWlI1LkYmg5RgTI6pN/s8mGB9CPqc15
	bRO2cSSyWpxWwxkc7woIPM92T6sUq/8=
X-Google-Smtp-Source: AKy350bpN6OvAeFupLLjtd2p/lhCyQIeUgc6WUTJqfaNOwtNVstKDN4dl7mBXrL9iBvGNu6n461/Rw==
X-Received: by 2002:a05:6a20:65a1:b0:cc:5f8f:4f7a with SMTP id p33-20020a056a2065a100b000cc5f8f4f7amr9415779pzh.27.1680243460735;
        Thu, 30 Mar 2023 23:17:40 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062d35807d3asm888030pfw.28.2023.03.30.23.17.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2023 23:17:40 -0700 (PDT)
Date: Fri, 31 Mar 2023 14:24:31 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 3/8] erofs: simplify erofs_xattr_generic_get()
Message-ID: <20230331142431.00003145.zbestahu@gmail.com>
In-Reply-To: <20230330082910.125374-4-jefflexu@linux.alibaba.com>
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
	<20230330082910.125374-4-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 30 Mar 2023 16:29:05 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> erofs_xattr_generic_get() won't be called from xattr handlers other than
> user/trusted/security xattr handler, and thus there's no need of extra
> checking.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/xattr.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index dc36a0c0919c..d76b74ece2e5 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -432,20 +432,9 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>  				   struct dentry *unused, struct inode *inode,
>  				   const char *name, void *buffer, size_t size)
>  {
> -	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> -
> -	switch (handler->flags) {
> -	case EROFS_XATTR_INDEX_USER:
> -		if (!test_opt(&sbi->opt, XATTR_USER))
> -			return -EOPNOTSUPP;
> -		break;
> -	case EROFS_XATTR_INDEX_TRUSTED:
> -		break;
> -	case EROFS_XATTR_INDEX_SECURITY:
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	if (handler->flags == EROFS_XATTR_INDEX_USER &&
> +	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
> +		return -EOPNOTSUPP;
>  
>  	return erofs_getxattr(inode, handler->flags, name, buffer, size);
>  }

