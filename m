Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F16715F47AD
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 18:33:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mhjth4FNLz307g
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 03:33:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MGBgCAXs;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MGBgCAXs;
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhjtZ4hJdz2xmw
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 03:33:10 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 2B3BBCE0979;
	Tue,  4 Oct 2022 16:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC19C433C1;
	Tue,  4 Oct 2022 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664901184;
	bh=G/6nvWGXio6q3wgzzadZLId8o2xSNMqbYcEL9LRjSdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGBgCAXsC543Edtndrz1+clAwCEZgHx5DBdcWYZ1f20Qt2yDCwGyCsFGCdpj8p+2n
	 m/yZnWZAYNP3m6yDkNPiqpz/Ym2UrpSiUrv9KU6gAmIxbRGUbCU8Ce54y3aXvoQfpZ
	 hyeBjBpow8xM/v3IaxLWdAn7vPeC8A8GY+Y1JY9A3D49HZnUFA3a5KdZbgraCod9GG
	 Z7GSvLCzfq9nraOTzPbQ30q9SOIaYJHHls+GC/Au4iWPh1HOakHXf+8Abi1nTC5w1s
	 SraR/mEbcn+uwAo4Gqf79othNVMjqeueEisqJ7cM3OqQLBou/11o5rN+xqiShfjDQk
	 SnfzXBpR+DXEw==
Date: Wed, 5 Oct 2022 00:33:00 +0800
From: Gao Xiang <xiang@kernel.org>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Add volume-name setting support
Message-ID: <YzxgPKoi9Q1scK3N@debian>
Mail-Followup-To: Naoto Yamaguchi <wata2ki@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
References: <20221004160237.10849-1-naoto.yamaguchi@aisin.co.jp>
 <YzxcOcJK+8gB8psP@debian>
 <CABBJnRa6S87f9uwuUEfR55rKHwnhkpDVtfPvX0tcoZWc_2vgow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBJnRa6S87f9uwuUEfR55rKHwnhkpDVtfPvX0tcoZWc_2vgow@mail.gmail.com>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 05, 2022 at 01:25:48AM +0900, Naoto Yamaguchi wrote:
> Hi Gao
> 
> Thank you feedback!
> 
> >1) How about following mke2fs by using "-L volume-label" ?
> >https://www.man7.org/linux/man-pages/man8/mke2fs.8.html
> 
> The mkfs.extX is using "-L volume-label".
> The mkfs.vfat is using "-n volume-name".
> I think both better.
> You commented to "-L" is more better, I will change it.

Yeah, I tend to follow mke2fs if it has the similar
function if possible, since it's more widely used :)

> 
> >2) If possible, how about adding a kernel ioctl for this if you have more interest?
> >I mean FS_IOC_GETFSLABEL.
> 
> It's interesting feature.  I will try to work it.
> 

Thanks a lot! Yet that is not urgent since 6.1 features are
already fixed, it needs to be landed in 6.2...

Thanks,
Gao Xiang

> Thanks,
> Naoto Yamaguchi.
> a member of Automotive Grade Linux Instrument Cluster EG.
> 
