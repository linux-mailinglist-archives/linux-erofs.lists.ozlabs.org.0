Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 021046AF89
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 21:04:12 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45p8vY3YPvzDqZG
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 05:04:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ub7qkkGv"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45p8vT0yyyzDqPF
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 05:04:03 +1000 (AEST)
Received: from localhost (unknown [113.157.217.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 92E1420665;
 Tue, 16 Jul 2019 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563303841;
 bh=3/ov3VwS9EiXrpwopTh1rrJAVNzOq+ih6WrfMLxRyjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ub7qkkGvDvkP+GeSSsaTu9TylY6bx4RaiJ5eLv7Ipn884BgdOl/DPIBJyQtGEZ53E
 aM0kTYj/QqcTxrKDF+i8wQugGgoyx8VdZWdXL4+p+Na8I/QC21HvLFKlTA2btfMpZl
 TW4Oq3320MgnKeEjFXI4/xR5+nwDnwitZDHNvxZA=
Date: Wed, 17 Jul 2019 04:03:58 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Karen Palacio <karen.palacio.1994@gmail.com>
Subject: Re: [PATCH] staging: erofs: fix typo
Message-ID: <20190716190358.GB20227@kroah.com>
References: <1563295663-312-1-git-send-email-karen.palacio.1994@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563295663-312-1-git-send-email-karen.palacio.1994@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org, yucha0@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 16, 2019 at 01:47:43PM -0300, Karen Palacio wrote:
> Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> ---
>  drivers/staging/erofs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can not take patches without any changelog text, sorry.
