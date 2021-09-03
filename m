Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0494001FA
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 17:22:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1M426yG5z3c5X
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Sep 2021 01:22:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G9taxmWO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G9taxmWO; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1M2y74VMz2yPy
 for <linux-erofs@lists.ozlabs.org>; Sat,  4 Sep 2021 01:21:46 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDF58610CF;
 Fri,  3 Sep 2021 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630682504;
 bh=TdBn9mkeEdGmO0QJL0FMEm+4QM2+l6bPCLRMTNcWPvU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G9taxmWOLjtB5VG4Tx4Pxo9ygf8Nk9WR3FcXG69o6LKFiWo7f1RRlTZaOq1cTuam7
 acJU2I009wzWk+GUgi0a5LJouCAcYulXTFCTZEsCgKqmv9cUh96A5szuy6nEVRzKfX
 tQAxAC1oiKXEAVQS2PtA2axoq+7CiafE4TN2CZI1rZRd3hOzVIetwdnmhiA+KQNHD4
 kh2hEY4/3SThk/MAGV2KF/MPNyhlYnxkERjqFm/4mJ2lV/cRUmBUyFrfWlZwnxfXvv
 DoHBG3S67BpBxyYo/lrKJCAD+woxlRNMWe9e9mmr3UkSwAMVWrlVzR6lR5i7yw34rP
 4N0q4XL4doSzg==
Date: Fri, 3 Sep 2021 23:21:16 +0800
From: Gao Xiang <xiang@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH V2 6/6] erofs-utils: add missing /* fallthrough */
Message-ID: <20210903152108.GC6059@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <jnhuang95@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210903134035.12507-1-jnhuang95@gmail.com>
 <20210903134035.12507-7-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210903134035.12507-7-jnhuang95@gmail.com>
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

On Fri, Sep 03, 2021 at 09:40:35PM +0800, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
