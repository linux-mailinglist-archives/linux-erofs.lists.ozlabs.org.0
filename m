Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 166291F90E2
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2020 10:00:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49lkJr1sMRzDqZ3
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2020 18:00:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=GCOE2Fm7; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GCOE2Fm7; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ljY52LxxzDqWx
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2020 17:25:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592205938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHwguCxo4c2cVMancqpzmFcNo1EaIuQKAA2ekR4KvOU=;
 b=GCOE2Fm7g4josB58KcGs6d2gaIGK6bLNHyz13zHsw5QZsK3DaMDknALxfBPvKTWpqwO+Of
 347M9uM0f/PNjS4OoeG27xT5wnkVKGlinTOSyR/Y2kPjkW6aiDOZlLkrK1xsBCjK9qxvgb
 +nZp3nxOFVJ+SVLCMyNTU38bSECgM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592205938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHwguCxo4c2cVMancqpzmFcNo1EaIuQKAA2ekR4KvOU=;
 b=GCOE2Fm7g4josB58KcGs6d2gaIGK6bLNHyz13zHsw5QZsK3DaMDknALxfBPvKTWpqwO+Of
 347M9uM0f/PNjS4OoeG27xT5wnkVKGlinTOSyR/Y2kPjkW6aiDOZlLkrK1xsBCjK9qxvgb
 +nZp3nxOFVJ+SVLCMyNTU38bSECgM44=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-KHfU9XqYPWGuKA98QlLftw-1; Mon, 15 Jun 2020 03:25:34 -0400
X-MC-Unique: KHfU9XqYPWGuKA98QlLftw-1
Received: by mail-pg1-f197.google.com with SMTP id k124so11582745pgc.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2020 00:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XHwguCxo4c2cVMancqpzmFcNo1EaIuQKAA2ekR4KvOU=;
 b=C1XpH2NK8WVc8hDXlho/QMFGXz/MhdQWcHM8Y4pjzCkdC9wqEgLJR++Jmyw8UkSZuX
 HV+ZWWUaw2v4O8N3l5zhB4zXX1ohxT+edKxJnx+nzdn6HH8IqW6P9VdQBqpOzByIMMmn
 pn3k7UGKijFrxV3SUes51gjhtq1O80hICqv6IpoMRtzlm18BtzOH8mVNKBHAKXOHUQrX
 +Wvq1T4D3wEEEvnWwl0Xt15AI5IEYVJG+RUYst2ebwC2YSl3worp7ZXawbLCDMb7RS0T
 VrP2Ts+kJsOMVrc4Y4MEY0QaA0Gu32O9V08W0p9sovOrWpgVLOWxOIlNej7rtsio2Atp
 cp6g==
X-Gm-Message-State: AOAM531CccyNxg2BW1ZX/S0dQv90kxARRUoy5qso+5aS86GLommLdcW7
 fsfkc9kCyAMO2Oxub6dC4PtJEO09DRZdsxGxph1nKHamL1cFzhBAKcl77y9QhOxtN7AIZNGOcsA
 xriYew0EZ5Hz0pxZ3NU7n7CRr
X-Received: by 2002:a62:7ccb:: with SMTP id
 x194mr23171909pfc.318.1592205933332; 
 Mon, 15 Jun 2020 00:25:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYaTupNZjWJqlIUP4l94FShAOlauozvMBU4WlPvbNTKjhwYoirQ+2pYQeFVKE9wK3gIS1IOw==
X-Received: by 2002:a62:7ccb:: with SMTP id
 x194mr23171888pfc.318.1592205933006; 
 Mon, 15 Jun 2020 00:25:33 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id mw5sm13015199pjb.27.2020.06.15.00.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 00:25:32 -0700 (PDT)
Date: Mon, 15 Jun 2020 15:25:21 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH] erofs: Eliminate usage of uninitialized_var() macro
Message-ID: <20200615072521.GA25317@xiangao.remote.csb>
References: <20200615040141.3627746-1-yanaijie@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200615040141.3627746-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jason,

On Mon, Jun 15, 2020 at 12:01:41PM +0800, Jason Yan wrote:
> This is an effort to eliminate the uninitialized_var() macro[1].
> 
> The use of this macro is the wrong solution because it forces off ANY
> analysis by the compiler for a given variable. It even masks "unused
> variable" warnings.
> 
> Quoted from Linus[2]:
> 
> "It's a horrible thing to use, in that it adds extra cruft to the
> source code, and then shuts up a compiler warning (even the _reliable_
> warnings from gcc)."
> 
> The gcc option "-Wmaybe-uninitialized" has been disabled and this change
> will not produce any warnnings even with "make W=1".
> 
> [1] https://github.com/KSPP/linux/issues/81
> [2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---

I'm fine with the patch since "-Wmaybe-uninitialized" has been disabled and
I've also asked Kees for it in private previously.

I still remembered that Kees sent out a treewide patch. Sorry about that
I don't catch up it... But what is wrong with the original patchset?

Thanks,
Gao Xiang

