Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8045AD5D1
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 17:13:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLsVM4Vr6z3010
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 01:13:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Sk2YEw3p;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Sk2YEw3p;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLsVG0Dwbz2xfm
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Sep 2022 01:13:41 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AA708B811EC;
	Mon,  5 Sep 2022 15:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011AAC433C1;
	Mon,  5 Sep 2022 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662390816;
	bh=i3QTbdMoweBqG6ifb88wDs67D5ImR67NR/mA5Nf1DUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sk2YEw3ptxgITGaaQsmqB9Yi0q7EhFfJvrGJgy75VonToOTi0hcz68F0YBcOzrVeI
	 DCwl0HsDH6fXkXb18p1pJJ+YFukFnBkxDKyMB6XMPysw5n6X1A+gvmaKV1j9VN/uKt
	 VyKMY4BO4j+pGHVBxSPv9+ss/tRbueCWNz8rTbEF1vhDYfsHkiksT6UbhokgamrkVy
	 +6ZUYvyIE2ygAN5Rl1c8gn5pZ+Qe14K1ZG+73dp7jWZp0dTsrK2pWZlf/pJ5NGCqsf
	 ImCBDdeXDedHzQkEMtZ9pP7EyzIzhrtMK4AV6TFTkjnRKZDBBIw1c1jiPa2/TsycPn
	 TuePZeAYdvaoQ==
Message-ID: <14ed6455-9678-fa32-aaf1-cc34f492d4ce@kernel.org>
Date: Mon, 5 Sep 2022 23:13:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] erofs: avoid the potentially wrong m_plen for big
 pcluster
Content-Language: en-US
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org
References: <20220812060150.8510-1-huyue2@coolpad.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220812060150.8510-1-huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/8/12 14:01, Yue Hu wrote:
> Actually, 'compressedlcs' stores compressed block count rather than
> lcluster count. Therefore, the number of bits for shifting the count
> should be 'LOG_BLOCK_SIZE' rather than 'lclusterbits' although current
> lcluster size is 4K. The value of 'm_plen' will be wrong once we enable
> the non 4K-sized lcluster.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
