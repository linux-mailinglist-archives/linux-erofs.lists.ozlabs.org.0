Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A4C2FF94F
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 01:16:33 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMKYp2jSXzDrVP
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 11:16:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=TJmBeqZT; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TJmBeqZT; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMKYh0p08zDqW7
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 11:16:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611274579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OEUHNmj2c+6xzQ3C4zUEpnec1vic/0zaToT3PoT2vUM=;
 b=TJmBeqZTUeNcykx7vaKGNA+ZbMFLaWEdbyFS9KG/DHMTCzH8imdGD8iua1BZs/srIVgCk/
 mJERTK5Kj4JU1Y68JRxNufZUKaynV7a5cPOd1BHMxJenx0c41b+74rTls3CxeXqmspe8gv
 qq5sWk6fxClz5i9vWunyuTc5qaatMxw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611274579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OEUHNmj2c+6xzQ3C4zUEpnec1vic/0zaToT3PoT2vUM=;
 b=TJmBeqZTUeNcykx7vaKGNA+ZbMFLaWEdbyFS9KG/DHMTCzH8imdGD8iua1BZs/srIVgCk/
 mJERTK5Kj4JU1Y68JRxNufZUKaynV7a5cPOd1BHMxJenx0c41b+74rTls3CxeXqmspe8gv
 qq5sWk6fxClz5i9vWunyuTc5qaatMxw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-iUC4gexEP06SGsjiQKGJxQ-1; Thu, 21 Jan 2021 19:16:17 -0500
X-MC-Unique: iUC4gexEP06SGsjiQKGJxQ-1
Received: by mail-pf1-f197.google.com with SMTP id y187so2234069pfc.7
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 16:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OEUHNmj2c+6xzQ3C4zUEpnec1vic/0zaToT3PoT2vUM=;
 b=DpiZNvCgpV2fKhq/ydeylOXUlFZaXw9ZIFKLedD9/zfXwy0Doas3ChiDm2VkpSNLAB
 rg+61EWVFbEoKkRap5Sqcd6++AAH+LaRzXbNGvqracn9oMp2BhLEGkIjdDkXMHccdO3r
 8yOBTpqQJQ+QepjBjN4jaMIqjppVSqC2epP5Jqsj5JDJWsygggZMw2z0H7Zkg65Z5C74
 CkDAAzwPA8O6UXcLRO+vFZCCWkc7nmu+p231DlQ50FQuQisvrgtpryyWgkx77eb+URLn
 xPSj9uQp97LXQJDlhi4R1ZT2rOW8AiJ7aNIpdP4UUXH0LlPzH7RrzmrJG0HrvPxSp/oy
 r4yg==
X-Gm-Message-State: AOAM532St4mk8hOwYhmmbv7qkYZmryFGc2olZAe9YIr/I+eHql7gcG/h
 qwjn3i7fjnr15tMLLkMmhHzubWcDfjiZ41arrlQDqu2U8gUzVR/I0QelA6Kybfx6N6V3G8uaYLX
 x/uFm0jEWJfgqSvmyio/WAvPW
X-Received: by 2002:a63:2265:: with SMTP id t37mr1910115pgm.336.1611274576248; 
 Thu, 21 Jan 2021 16:16:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwdDiyWswqFIs02xtsORaOM6j4Zl2KiNd8HQyY1UPYum0lhqgVq+XHHhw4mfQyTqgvyvJbJQ==
X-Received: by 2002:a63:2265:: with SMTP id t37mr1910098pgm.336.1611274576006; 
 Thu, 21 Jan 2021 16:16:16 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s11sm5724834pfu.69.2021.01.21.16.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 16:16:15 -0800 (PST)
Date: Fri, 22 Jan 2021 08:16:05 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH 4/7] erofs-utils: tests: fix distcheck
Message-ID: <20210122001605.GC2996701@xiangao.remote.csb>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
 <20210121163715.10660-5-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210121163715.10660-5-sehuww@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Fri, Jan 22, 2021 at 12:37:12AM +0800, Hu Weiwen wrote:
> To get required files to final .tar.gz distribution:
> * Any header files should goes into _SOURCES.

should we use noinst_HEADERS instead? do you have some reference
link (I mean document) for this? what's the impact of this,
just dictcheck? I'm not familiar with that...

> * check scripts should goes into dist_check_SCRIPTS.
> * 001.out will trigger a GNU make implicit rule, rename it to 001-out

How about also renaming $tmp.out to $tmp.stdout?

Also, 'since experimental-tests' has't merged into dev, do you mind
me folding these bugfix patches (I mean except for "[PATCH 5/7] and
[PATCH 7/7]") into the original patches, and add your contribution
description & SOB(Signed-off-by:) to the commit message? That would
make the whole commit history much cleaner... If you agree that, I
will resend the testcase patchset later with your fixes and new
patches and wait for Guifu to review if he has extra free slots.

Note that, only dev & master branches have stable commit ids.
experimental-xxx could be rebased frequently.

Thanks,
Gao Xiang

