Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00838A002
	for <lists+linux-erofs@lfdr.de>; Thu, 20 May 2021 10:40:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm3942RWkz2yx6
	for <lists+linux-erofs@lfdr.de>; Thu, 20 May 2021 18:40:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JDVbF+LV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JDVbF+LV; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fm3924MNMz2yYM
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 May 2021 18:40:38 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7023860E09;
 Thu, 20 May 2021 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621500036;
 bh=9lMFE/wOwBjZrwNwRhEMmXbUPibX8C5KbGbXR7vX1Ik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JDVbF+LV3KbT3feNmZ7ctQnbsm8METdwil3rB9cebi2S08lFMi88QvAi7DZKh9l8c
 Vp40W+3XgSse8WpKibMC6iA2Yg91S/GUGJlvA4Z4VFp2Vb8JAqRkH8BgavRjd9lpdJ
 XFQNWaYdqeKtf1rKoeITxKJw2RaWZKdVAmqZclbtUx04K8OvZ13WvDWJW9kUFPwWMm
 +iL4XPqNf8Tycw5XeSgRHZdG12yv1Dr+AWKuYakSq69IDB3L2qMtahkBLcExss+2Hm
 /6vQIg67Ou81VCyhkmXhAeUOuPiU1x6Zu1DobmGjJM2bB1Jk6Zo9s7i+8kAr6r/RtK
 j6495jlX4l1Iw==
Date: Thu, 20 May 2021 16:40:24 +0800
From: Gao Xiang <xiang@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] erofs: fix error return code in
 erofs_read_superblock()
Message-ID: <20210520084023.GA5720@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210519141657.3062715-1-weiyongjun1@huawei.com>
 <20210520053226.GB1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210520053226.GB1955@kadam>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hulk Robot <hulkci@huawei.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yongjun and Dan,

On Thu, May 20, 2021 at 08:32:26AM +0300, Dan Carpenter wrote:
> On Wed, May 19, 2021 at 02:16:57PM +0000, Wei Yongjun wrote:
> > 'ret' will be overwritten to 0 if erofs_sb_has_sb_chksum() return true,
> > thus 0 will return in some error handling cases. Fix to return negative
> > error code -EINVAL instead of 0.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> You need to add Fixes tags to bug fix patches and you need to ensure
> that the authors of the Fixes commit are CC'd so they can review your
> fix.  get_maintainer.pl will add the author automatically, but normally
> I like to put them in the To header to make sure they see it.
> 
> Fixes: b858a4844cfb ("erofs: support superblock checksum")

The commit and the tag look good to me (sorry for a bit delay on this),

Fixes: b858a4844cfb ("erofs: support superblock checksum")
Cc: stable <stable@vger.kernel.org> # 5.5+
Reviewed-by: Gao Xiang <xiang@kernel.org>

(will apply to dev-test for a while and then to -next.)

Thanks,
Gao Xiang

