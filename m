Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49331589E19
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Aug 2022 17:03:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LzBmj0x22z305v
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Aug 2022 01:03:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HcGb7zKF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HcGb7zKF;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LzBmc6F21z2yK2
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Aug 2022 01:02:56 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1B04660E09;
	Thu,  4 Aug 2022 15:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB6C433C1;
	Thu,  4 Aug 2022 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659625372;
	bh=N36ohfAXmBinZzgRiQoVMOwDRQXXUgBPnkzwZD5mF+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HcGb7zKFxNN88VyqjiLf3dj5tzOEQ0ZjKnlzVIF1WLGqA0tR4AiBQkD+Iym+eMEi/
	 TW+Q2MwHo1GaOWsr5qhY9Y/yJKPH/ponZEDeqmZMO0NFhmL8Kvn8Y5RNsAhsiOEbTC
	 wVqYA3H+4PczPuLQXhxlGvkh7dgydqkfQQFAhXxaDAC3mPVdKlptXTPVZQnqPdH6Rr
	 2GC9NmcAxx6FphkR1NHlDEBshWpeSHcp4m1z/lwxY9wJr0fOkHhyhsmM4n/atin9bH
	 Sx75yh+v5RkNEXwjBXr/BRN6FBksvxhpaI0Rf/fHFC7cBnJhNFgdxCvoEJTgl5Nwup
	 TrX+O7x//WUwg==
Date: Thu, 4 Aug 2022 23:02:44 +0800
From: Gao Xiang <xiang@kernel.org>
To: Sheng Yong <shengyong@oppo.com>
Subject: Re: [RFC PATCH 1/3] erofs-utils: fuse: set d_type for readdir
Message-ID: <YuvflEoj8S9ddA2w@debian>
Mail-Followup-To: Sheng Yong <shengyong@oppo.com>, bluce.lee@aliyun.com,
	linux-erofs@lists.ozlabs.org, chao@kernel.org
References: <20220803142223.3962974-1-shengyong@oppo.com>
 <20220803142223.3962974-2-shengyong@oppo.com>
 <YurPyAkkaHDD4Lih@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YurPyAkkaHDD4Lih@debian>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 04, 2022 at 03:43:04AM +0800, Gao Xiang wrote:
> On Wed, Aug 03, 2022 at 10:22:21PM +0800, Sheng Yong wrote:
> > Set inode mode for libfuse readdir filler so that readdir count get
> > correct d_type.
> > 
> > Signed-off-by: Sheng Yong <shengyong@oppo.com>
> 
> Reviewed-by: Gao Xiang <xiang@kernel.org>
> 

I'm not able to apply this patch since it's badly
space-damaged...

Thanks,
Gao Xiang
