Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 77295967FC4
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 08:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725260160;
	bh=XfZhXkCYvOtW1sxHDzbWqEkBBNjZmOjtwdwPjllgAdo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oV0ADznPQP+/dYNa8MW6AjVWaw4z/ZJdo4mBUNJ0gBDA6Ugj2uZQdb3qxxS0EbwiG
	 7Sheh15xZ6m7ptLyYUYdhhmxSRr4fvNwIwnXFQKMidm49uDv0t+0ySLIVQXhibJWnN
	 M2O9mmZrqtGOKO29ulmAoPctKAJgSp4qCEpaifmEWQKynE2XzUx2QUBoe3uGV1Pffd
	 VNpAHEdO22QkhPUHYQdXLfTwX63qtrsBDCaxMje3KUtdYUWkiE6dD2MsSu6qLCXYcs
	 nGyLk1jQekzvb2U27kJUdEKeQjtbnWeoG9Dotv6kdpTWAy0EPwDMRhTV8+WKKDanIx
	 6UFjBPHyIZMQQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy0000sD6z2yPR
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 16:56:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725260158;
	cv=none; b=KUDGUHS00OC5gbP3gl4HZ5yJeNOXxFZwSqQ5jNJEkaEFl9nWB335Mr2slhJQKmNeAyE0ISSPLzJLZqNGBtAVBV++tvluaYTMr0Xd4FR+3V1RLfLfR/8DuaLSevYpiGYdl3VSvfq9fo0MRmzcKwxU9JzARuFjH4boizVjgXIk4xqcSY4s4+/39EkJoO55H6XrrWr1jBvVUmlWRoGpGCdMvQxyRRKf6HOSwX7bPpgaDhVAHDUYvhezqHHkI/4U93OD3ZjX5VQrBHEkXdxMosL5bVZX8HnZUiYctgebhGPGPCN9CcN3gHM7avVLFlDmKQCETtAfrbMen8vR7WeXdCntgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725260158; c=relaxed/relaxed;
	bh=XfZhXkCYvOtW1sxHDzbWqEkBBNjZmOjtwdwPjllgAdo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version; b=TWI//2nJH7ENFk9s7OJOUrtUNeS1Pkvk9M/Y2EuWVPptfIgg502Pd37o9EMuTus+hhaREz1Yg9nBzl07xdMSQVCXDJdkYnvXA6MP1tuEn3HS0LNKOL/b2dftjl5cP5HCa2jbGwCz1+tLthlUVwPPvqSLbXkmROe5Ajr2R/tQx5LsNj9mZuY8sbzq62syi4nrXDnzWoZdm22WJ+UWK43Hph7ZASF+qAdkSFkl/pm8gR8haJThb582x3QRp817EjkfSvbP1Vocyyx2H8OPP6eKdbb7shvODkVm7SY5PawGNZv8lnkVQETH5DGEDAM/u5ntxa5AJ/5r0Tl4C5BVg1H0HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Vr/KsGEA; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Vr/KsGEA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wxzzy3l2cz2xT9
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 16:55:58 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4D2569839;
	Mon,  2 Sep 2024 02:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725260155; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XfZhXkCYvOtW1sxHDzbWqEkBBNjZmOjtwdwPjllgAdo=;
	b=Vr/KsGEAaiWpxdclsqo21fJWZUMU6shwgx/rfW5SYPr2cgBdUh/smntu/tERFbPylvgWaw
	d6PEUctpuUpXZ5mlJKTgGn3iRkH1UDoAQ5jg+qbnvM8tunIyWWa/bYKmvNHKuaKvpY0U8o
	YCq9ToZQt/kY2ehdomAc9vs340RPtQNFPFBUYDNZpJu6zuSg6fgBOrnrkQ1MyRb/kQv/hx
	Iadxj8wc9g/kT70io8vPVKKdg0cb5AJ/wjDo9t9XhNGi3ngdbOw7YSojltXbowCRhmUyjD
	lYJEDqFqQJW9PVBmlnpUO01U9XRuqR35fM0GSVnffaFq22XHJ3tXS605nrJuhA==
Date: Mon, 2 Sep 2024 14:55:49 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: refactor read_inode calling convention
Message-ID: <dmmp2g7erhdwsg6tnzh3loobkuxytewrhulkepio7ek4tbjlci@padw5k3yvujw>
References: <20240902045100.285477-1-toolmanp@tlmp.cc>
 <20240902045100.285477-2-toolmanp@tlmp.cc>
 <eaeecdd2-9689-47e8-963b-f6aa9ef7d9cd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaeecdd2-9689-47e8-963b-f6aa9ef7d9cd@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2024 at 01:52:59PM GMT, Gao Xiang wrote:
> Hi Yiyang,
> 
> On 2024/9/2 12:50, Yiyang Wu wrote:
> How about not changing this, but add another if for this.
> 	if (S_ISLNK(inode->i_mode)) {
> 		err = erofs_fill_symlink(inode, kaddr, ofs);
> 		if (err)
> 			goto err_out;
> 	}
> 
Yeah, i've decided on this before. But my initial intention is to avoid
another if statement. Sure, i will change this.

> 
> 		if (inode->i_link)
> 
> I'm not sure if `scripts/checkpatch.pl` still has the rule,
> but EROFS codebase don't compare against NULL.
> 
Fixed.

> Thanks,
> Gao Xiang
> 
> >   	/*
> >   	 * Return the DIO alignment restrictions if requested.
> 

Some of the styling bugs are introduced by clang-format, it's included in root so i accidentally
formatted the code. I will fix them in next version.

Best Regards,
Yiyang Wu
