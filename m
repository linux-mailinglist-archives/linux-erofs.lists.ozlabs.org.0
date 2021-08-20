Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9DC3F2C72
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 14:49:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrhKh16rLz3cLV
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 22:49:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MKCusk+x;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MKCusk+x; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GrhKY2Q2Vz30C0
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 22:49:21 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0BFB610CC;
 Fri, 20 Aug 2021 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629463758;
 bh=gVkPf8yrqL7Lu8ogQebycHK4/XL6EJAP5xzTADif8t0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MKCusk+xO9/wtl92NUXY90mp0E8zaF8EPRFSA3QEHFuei2vCpEeBe2OymVxPWJcWL
 9hywCNgEW/tUMU1/+FXaxKwvXXjHzGISkdz4Q2aptqUW4aLuZCFFipyTMYqiwUveOE
 osMk+DV+hmKr99x36woh2Cp0LBMgBC2cVTGM25I5oD/90a7hvUXfhQ34TOQ2FFiCN0
 f09koVZMakBMxMTW26b71yvzHsScBzec8LIc57d6AL+ewS65tEf/sbZhPts6efk6ws
 GLKuNPTixmzWVZhSjD266bqB+pDRHUy7FDYDAikcivl/5CG15sSYkDhA774F7aAcL4
 WY7/85kwGFdsw==
Date: Fri, 20 Aug 2021 20:48:37 +0800
From: Gao Xiang <xiang@kernel.org>
To: Igor Eisberg <igoreisberg@gmail.com>
Subject: Re: An issue with erofsfuse
Message-ID: <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Igor Eisberg <igoreisberg@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
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

Hi Igor,

On Fri, Aug 20, 2021 at 03:34:05PM +0300, Igor Eisberg wrote:
> Hey there, getting straight to the point.
> Our team is using Debian 10, in which erofs mounting is not supported and
> we have no option of updating the kernel, nor do we have sudo permissions
> on this server.
> 
> Our only choice is to use erofsfuse to mount an Android image (compression
> was used on that image), for the sole purpose of extracting its contents to
> another folder for processing.
> Tried on Debian 10, pop_OS! and even the latest Kubuntu (where native
> mounting is supported), but on all of them I could not copy files which are
> compressed from the mounted image to another location (ext4 file system).
> 
> The error I'm getting is: "Operation not supported (95)"
> 

Thanks for your feedback.

Could you check if lz4 was built-in when building erofsfuse? I guess
that is the reason (lack of lz4 support builtin).

If not, could you add -d to erofsfuse when starting up?

Thanks,
Gao Xiang

> Notes:
> * Only extremely small (< 1 KB) files which are stored uncompressed are
> copied successfully.
> * Copying works perfectly when mounting the image with "sudo mount" on the
> latest Kubuntu, so it has to be something with erofsfuse.
> 
> Anything you can do to help resolve this?
> 
> Best,
> Igor.
