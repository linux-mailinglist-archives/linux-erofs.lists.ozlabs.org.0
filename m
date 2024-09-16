Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE797A773
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 20:51:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6vBh4xGZz2yRZ
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 04:51:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726512663;
	cv=none; b=R9MiJIq6TW2KpxgWFAKKmVC1HWzao532KLBTR9rfz8iLll21oarFTmtRcVQTlfOwH8omm20cdvH3OW8lFDZZDESnjF3Py409vNMMW6ySQm0I2WvPZycaBPF0npeFat16mqcW6qFSjHdGjVY/i80p+2QETTQYxyJrDCH7WMcvlkhpnL8cMwPDD9RPQX/i+O2I2g+Y6MMft2vswBHrbw+m1aYdOp1g6CnAyTHUMQJkdcL5F4d7+g6sXKp+rH47DP1dazuyn8uv4YkGiAkIb9+wQJXMWczu6NAvfIK82E8unHG/S19vbym6yJy813H5gbd3gTepSoLaIjzTINtS0rJhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726512663; c=relaxed/relaxed;
	bh=adUp/sdNh0NB4Ae6rE8BvvXgKSjUbI0UwzPmTNj4k88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3LlVEx/J3TwNlUO6rHN9kXbp5sDq86F/dD5mbsNYXkYqCO99atybs4B1rgYwcpJ8iOexnz0q/OYsjR+bl07WHtMeNvdsQdjaS76yrnze4m7oGZSFNu934Tk35N+EOu+fqIvsbXdAeClrTT30n9OuB8fr3yePqvmNL5UvUP7w9uRcyIJiICnKMg+YqtMyU27jZLx5Gxp4Yion1uM+VEwEhbcUjoaEWTQdWUmeq7YK+TKy7cPvHGl658jBJIvD+A8cFJdsjMkbTIykr1t5jJSHwfpROggDg8IaRCHMNEtqWv6sZ8zOyJBNKxhpumnYPMzvdra0NpdA2mUhP//hwZ9fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=S6yD6dTj; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=S6yD6dTj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6vBZ467Pz2xjh
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 04:51:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3AB225C5CB2;
	Mon, 16 Sep 2024 18:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBDDC4CEC4;
	Mon, 16 Sep 2024 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726512658;
	bh=UIh1dpfLpZcsRwWvhy2J3nv47RD0JA14+2b7Tr05Khw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6yD6dTjgIAue8lwjRCRxC2lsU1jDpa630eA+sYkenHs5MViz8+wv1R/FgEZkEIn2
	 ffRp79MrTCImoaNu/rRbRY8G9v8GZ3B+e5jpdN0DsuEJm00Xwcbd/cfpoysa3rlV1E
	 Ke0x6NlsJNOtiShGQ/BdvUd/ZrQgrxefxeiU/f0I=
Date: Mon, 16 Sep 2024 19:51:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yiyang Wu <toolmanp@tlmp.cc>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <2024091602-bannister-giddy-0d6e@gregkh>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916135634.98554-4-toolmanp@tlmp.cc>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 16, 2024 at 09:56:13PM +0800, Yiyang Wu wrote:
> Introduce Errno to Rust side code. Note that in current Rust For Linux,
> Errnos are implemented as core::ffi::c_uint unit structs.
> However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
> 
> Since the errno_base hasn't changed for over 13 years,
> This patch merely serves as a temporary workaround for the missing
> errno in the Rust For Linux.

Why not just add the missing errno to the core rust code instead?  No
need to define a whole new one for this.

thanks,

greg k-h
