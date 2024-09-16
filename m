Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBE97A774
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 20:51:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6vBj6zFVz304C
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 04:51:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726512665;
	cv=none; b=JFHqURGvXgEbB9lGYKZxlM6DOTV9BPkemH9ZnbK8gzc6EEIrdrd+/NaoIthcGFclSN0hO57VI5MSeefznRZHVC7PeqAfb48pfZt1yvH0IUgfbv5pqTF6yPZvGcdElgTcJImESRLBhq+amGIAwATq2ViNZGLDKrjVpkKQwNNvg0gmoiggBmBnPLB5WlT0IG7HrDOjXFTGrDTKQtK6bV9r2hyqoC2/CNN1/9MUVtxibzo61I2Qym1iO3of2oLQoLKsTM9+nDBm7Me0j8dfSW1B+O6kOcCfS9PhZoqXJqXGvU9hjUwtEdo4Rfz/vJe4ti5TwOfAN3Cv4smduGW/K2f5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726512665; c=relaxed/relaxed;
	bh=LEbWnfJGJmKt+Yr5iWMNIIRlpA2VvaunAoOdVU7T1ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmPr8biw53a5O8EdSpoaoqTWE64codaAO1NvjP1Bp34JjDsfdHmju7bUD5fVEBw5SnG/45CcwM3ycy6NPlRqh6wcHlp/beHTAQlTy7YOjTWa0L8AB60QbxL9ArjvUtQ8sGCNQ0K8Z76lZpg6bnv/s5PJUbs93RwkeFrJUzStBl6mmqYbR9Mk3wmgIn/RNSaEOUbnnMGPauHrvC95JILdTojC6b4g0+CayL2JOrmnPAbybYGE/btDxs2Tt7bmZYerJEVz+edR22yVq5zyn3jBnpEfJhasHZdw11B0Ky5SamSJXqacKZEofmuLP987O4C7LucGphH/D1izfY0jrfjd+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VZub7Ckf; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VZub7Ckf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6vBc6mqFz2xjh
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 04:51:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2C9215C034A;
	Mon, 16 Sep 2024 18:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5A3C4CEC4;
	Mon, 16 Sep 2024 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726512661;
	bh=kmvv0I4Ktqu9r1ximFiGLBL2DIIDeLyJoXWdA9l9kAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZub7CkfnbGEVyQuEiC5+fKJkjCjtcPNanvKH5G9tdavMr+MyMgnhMoA6PmrH2O+5
	 fhV4BJDeKKXX8Qv0A95z0lnbLHzZWjdr2y8MBHiDFamcySYILeqhiTUwbVCn5W3T7H
	 P/GlkdG/6KNCN+/qTQy7KWU5LMlN7S4130oqvanw=
Date: Mon, 16 Sep 2024 19:55:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yiyang Wu <toolmanp@tlmp.cc>
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Message-ID: <2024091655-sneeze-pacify-cf28@gregkh>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916135634.98554-3-toolmanp@tlmp.cc>
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

On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
> diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
> new file mode 100644
> index 000000000000..0f1400175fc2
> --- /dev/null
> +++ b/fs/erofs/rust/erofs_sys.rs
> @@ -0,0 +1,22 @@
> +#![allow(dead_code)]
> +// Copyright 2024 Yiyang Wu
> +// SPDX-License-Identifier: MIT or GPL-2.0-or-later

Sorry, but I have to ask, why a dual license here?  You are only linking
to GPL-2.0-only code, so why the different license?  Especially if you
used the GPL-2.0-only code to "translate" from.

If you REALLY REALLY want to use a dual license, please get your
lawyers to document why this is needed and put it in the changelog for
the next time you submit this series when adding files with dual
licenses so I don't have to ask again :)

thanks,

greg k-h
