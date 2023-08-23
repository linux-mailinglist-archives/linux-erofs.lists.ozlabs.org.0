Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F1785BFC
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 17:24:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Co+v6/M5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW93m22SPz3c5L
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 01:24:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Co+v6/M5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW93j526wz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 01:24:01 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0BF70623F7;
	Wed, 23 Aug 2023 15:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F65CC433C8;
	Wed, 23 Aug 2023 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692804239;
	bh=FapS3wxTKtk8VB1dsiMNlDFRQOB2IyU6ewfeF6w6B6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Co+v6/M5I0B5OXkKM0hSprvDe17NV12AU2CkdZh9/BvVJpKAdAd5asMiXD17eTOvl
	 MuZaGouttmNmW8WUwDYyZTowToULjDgftiAqqi6503rKdYyof4n72b233R7FEXR34u
	 KyAMQCNxgscRGRvwvp0Hu2Kzj67z34wl4Jol4F8IpTw8ENipdmE7BBiJsLX5MoZ5f0
	 oOk/dLB00KEU/X6V3QMFN88/U8iNsQrAJW6aTiZ5rbIqxCJ/5lTFvP+KSqTAooLcMG
	 65id5zj9UufcS3GeI1D/E4Bq2syVWr+mO8DUUfKKsu9jo5yqoD86dMRe9EYo2Qy6K3
	 uXjxPePQc3T8w==
Message-ID: <b8c8efb7-2d67-19a3-864d-e59f64ab55ed@kernel.org>
Date: Wed, 23 Aug 2023 23:23:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/8] erofs: adapt folios for z_erofs_read_folio()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-8-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-8-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/8/17 16:28, Gao Xiang wrote:
> It's a straight-forward conversion and no logic changes (except that
> it renames the corresponding tracepoint.)
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
