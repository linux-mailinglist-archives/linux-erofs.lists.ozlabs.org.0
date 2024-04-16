Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2818A6F70
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 17:15:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kxl6KgN4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJndw2bSPz3dk2
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 01:15:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kxl6KgN4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJndm3DGVz3dH8
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 01:14:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 83FB56119D;
	Tue, 16 Apr 2024 15:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECEBC113CE;
	Tue, 16 Apr 2024 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713280489;
	bh=hay8TyvAejLuqRNPwkp2IBUbd+/60xM1k4IlF1iPK0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kxl6KgN427zN/n9KgKWvMQgFdLxxWNFB1i6mEwDTz5lrJWeTwcE/H7V6U+DmvERFI
	 8Rqfni8AsmsWODAII2xtctntQrj+my6vqWFOAbxeZf+qrJJ8n+nFMU5hWhrE7OnMge
	 FbEyEX9yBJaNvp4O92RnFgXCB/gqR35fmO7DRBT+l54+aWngPgX7X/XtVuupQyRF2T
	 MzRYmIr1MTO01HRdqGnAJs85n8sB8U25Oz+dS0pBW/WWhoykJD/8G7JrKFTbIs5CFx
	 fB3hP/HP5WGgGmwPMIAyG0kfiBBJtMB1+vrJWB3C1GrlWwhE96B2tnBn85C3pwuROD
	 ZDrcyYCu6Nj6g==
Date: Tue, 16 Apr 2024 23:14:47 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jianan Huang <jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: add DEFLATE algorithm support
Message-ID: <Zh6V51/K3NME8Fxc@debian>
Mail-Followup-To: Jianan Huang <jnhuang95@gmail.com>, u-boot@lists.denx.de,
	linux-erofs@lists.ozlabs.org
References: <20240414150414.231027-1-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240414150414.231027-1-jnhuang95@gmail.com>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Sun, Apr 14, 2024 at 11:04:14PM +0800, Jianan Huang wrote:
> This patch adds DEFLATE compression algorithm support. It's a good choice
> to trade off between compression ratios and performance compared to LZ4.
> Alternatively, DEFLATE could be used for some specific files since EROFS
> supports multiple compression algorithms in one image.
> 
> Signed-off-by: Jianan Huang <jnhuang95@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
