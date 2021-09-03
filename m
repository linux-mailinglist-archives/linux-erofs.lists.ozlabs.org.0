Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5144001B1
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 17:07:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Lk22H7xz2yMP
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Sep 2021 01:07:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZREiDBF9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZREiDBF9; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1Ljy0JsVz2xvf
 for <linux-erofs@lists.ozlabs.org>; Sat,  4 Sep 2021 01:07:01 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B607E608FB;
 Fri,  3 Sep 2021 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630681619;
 bh=1ToeIEc63aZlBp9Ir5eJqIKrQUuA8SeNIfQo87hN6zg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZREiDBF9pXS0j/NUPrQtOplZmYBjtsu36iyw/oFBxjPgP7Te3zf9AX9CmPdEMtA+O
 HwH4+uCm/JF8BOT9dbInKYhjhglxuDiyMVlryYYzfpnyTbtk4vS+LsL+QftCh4+2vO
 Mpvwsxh20rAObTesBBSXYeOCUyIAI2lTvRkTeePsSpQtv4oE8W/TaJFATprB/E6x4J
 OGYmp9nGaayrTcgX+VbFV8yQFK+cNUV4mkpvNRe1dNCTL9Xlb0dfLXYzq5aZ27qih8
 vM6oRUuQI5AP1hfLSik3cdUgzxnaswlf0x59ugt2SX7XBExzchpIUhy0iiFLE3onsh
 36bcEEue4N7Og==
Date: Fri, 3 Sep 2021 23:03:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH V2 1/6] erofs-utils: clean up file headers & footers
Message-ID: <20210903150355.GA6059@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <jnhuang95@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210903134035.12507-1-jnhuang95@gmail.com>
 <20210903134035.12507-2-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210903134035.12507-2-jnhuang95@gmail.com>
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

On Fri, Sep 03, 2021 at 09:40:30PM +0800, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> - Remove filename in the file since it's generally not useful.
> - Get rid of all unnecessary trailing newline.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
