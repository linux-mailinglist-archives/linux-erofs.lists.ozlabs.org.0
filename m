Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A55615F7C6E
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Oct 2022 19:46:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MkbN56VwJz3cfN
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Oct 2022 04:46:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LP8J88p4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LP8J88p4;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MkbN308M8z3c81
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Oct 2022 04:46:42 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 77F1CB8160D;
	Fri,  7 Oct 2022 17:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892F4C433C1;
	Fri,  7 Oct 2022 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665164797;
	bh=GYvJFCOsj2U1zfDFdDoeHoZGcUx99SoKzBKO4FXvIwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LP8J88p4uPSjSloYJKiszC6Q9OQ9Qv85yEaKADNULmXu1KJhprUXxKEPZfhohJHUN
	 NbonQo6MO2W0cat/n62wOxq67CtB9e2wezVpiAzjQTPQ1NHk6AKzqLj02wIju1caqQ
	 Ltc7WJ2aIcgnVOXZOS/dlbrhex4JkeuYeANtnYcBO50+d6YMyN4VQle7TpXQ9bDZlx
	 0OpfyK6QhN+rmGLKmD86KNZCngIRcCX7AfyhYkjlVOaMfKP+XCE4eptkP5E52pTEJb
	 Uau0O+zMJ2pfStM4QJhZVXl7pqFgr3IOYqLMnctQqW4JZTU+OElrseJYviNJHVYSqA
	 78xfkEPOWNCBQ==
Date: Sat, 8 Oct 2022 01:46:32 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yue Hu <zbestahu@163.com>
Subject: Re: [PATCH v2] erofs: fix invalid unmapped accesses in
 z_erofs_fill_inode_lazy()
Message-ID: <Y0Bl+G1uXaH2Au5N@debian>
Mail-Followup-To: Yue Hu <zbestahu@163.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
	Yue Hu <huyue2@coolpad.com>
References: <20221005013528.62977-1-zbestahu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005013528.62977-1-zbestahu@163.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 05, 2022 at 09:35:28AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
> after calling erofs_put_metabuf(), that is not correct. Fix it.
> 
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
