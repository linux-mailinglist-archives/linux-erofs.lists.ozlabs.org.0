Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1874438BC21
	for <lists+linux-erofs@lfdr.de>; Fri, 21 May 2021 03:59:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmVCy02x8z2yjK
	for <lists+linux-erofs@lfdr.de>; Fri, 21 May 2021 11:59:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FsXHeWuM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=FsXHeWuM; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmVCv1BMvz2xfw
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 May 2021 11:59:39 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5CF66135C;
 Fri, 21 May 2021 01:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621562376;
 bh=e0U0ENpEQZtPwZt1Bvq/qcUCSXVHYyFW2HBZQRx9NBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FsXHeWuMgkCZKTuoxbhIDhiocBZztInH1OI8ldvfcgltc85GoQoGwAZiKQXuUbb5z
 wxL59Y9HmewFpS4uQdB6uBDa/TwxRno6ZGVQiQQ7rpKyX4GrlEJXevxxdUz8F+JmD7
 i8u6VwHcLJvep+TBsRclcikbJ+VjWcRBiGM+wDn/DH7OJ9/njHwvthFs+J36IZetk8
 iyGjj5TvwczLNsIBVdD56XifQyRZDs8gS5IM0L57xrSW14WlYjT1i9KIJpuCB0TO5K
 fgT6qCk0sQsFo73j4iLmVDunnBn7WsNy7qKBSLj08yn+1Waw7ka1eTPmiFpNUFJXUg
 pG47FxMC0ubbQ==
Date: Fri, 21 May 2021 09:59:23 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: remove the occupied parameter from
 z_erofs_pagevec_enqueue()
Message-ID: <20210521015922.GB5725@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210419102623.2015-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419102623.2015-1-zbestahu@gmail.com>
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 19, 2021 at 06:26:23PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> No any behavior to variable occupied in z_erofs_attach_page() which
> is only caller to z_erofs_pagevec_enqueue().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Last time forget to add:

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

