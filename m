Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EF3F2DA6
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 16:06:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Grk2J55dlz3cLQ
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Aug 2021 00:06:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ckBCEBXf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ckBCEBXf; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grk2D6tB6z30JG
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Aug 2021 00:06:12 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01EAC610E6;
 Fri, 20 Aug 2021 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629468370;
 bh=bofNiEAZgtZJzhweUm3BxgGjokjElSWEjmtWP8oEyeI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ckBCEBXfhvLtzD6J0gzosaVzZqBzneo35jTvg4gwlwrSDQGq28JA1FjjgPnHujDcK
 XX01bnJ9AtojPY2QLaNrmKviEolSb09CW2B8MvQ7tWquJRJ90UfdJ1MNDMyYKTd4R/
 fanM9S430qGFh3NbOwDQV2cvP/9WfJkrWSHOqQPY34JABV/qT21iAiTq/FY8bm/Anc
 MyxWWgCEqaBMDrmp2W//k8x2gkZ4Cef5OgO82GtJ19XMxV/RHDpzlfRhyXkk1yND0M
 Yk1tYvNEZsp/riEL01kO4cph/WUPEOEmCnoSyN76GBT+m/QCH0D3cU5WCO/tUSJsLJ
 Q3U0GAP0oQjNw==
Date: Fri, 20 Aug 2021 22:05:49 +0800
From: Gao Xiang <xiang@kernel.org>
To: Igor Eisberg <igoreisberg@gmail.com>
Subject: Re: An issue with erofsfuse
Message-ID: <20210820140547.GC25885@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Igor Eisberg <igoreisberg@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
 <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
 <20210820132656.GA25885@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnFcM+Yib-SzNHBegabTjhoNvv7vH6WAkdZO1Vx13s-9xw@mail.gmail.com>
 <20210820134248.GB25885@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnFhPRg6unbsprCGSom284bHvnotTLk-s-0K078st_VR5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABjEcnFhPRg6unbsprCGSom284bHvnotTLk-s-0K078st_VR5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Fri, Aug 20, 2021 at 04:58:38PM +0300, Igor Eisberg wrote:
> Ah yes, silly me, got liblz4-1 confused with liblz4-dev, had to download
> the 1.9.3 *.deb packages manually cause apt-get is pushing 1.8.3.
> Now everything is working top-notch.
> 
> Regarding mkfs.erofs, I know it can take file_contexts, but how should we
> handle fs_config, if it's even necessary?

I think you need mkfs.erofs from latest AOSP tree, we don't directly
enable fs_config for generic Linux build.

Thanks,
Gao Xiang
