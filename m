Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CAF69672C
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Feb 2023 15:42:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGP7f3LDSz3cJ7
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Feb 2023 01:42:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VeyjyDkS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VeyjyDkS;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGP7W4QX2z2xZp
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Feb 2023 01:42:31 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BBB54B81DB2;
	Tue, 14 Feb 2023 14:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915D6C433D2;
	Tue, 14 Feb 2023 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676385746;
	bh=I5MIc6MM9QXD5jdrFO1awtvLE1Ii2eWvzUjvvLQmKI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VeyjyDkSNxgQ5Riew9CFnb7q7veDa9tanbxKKxtE2wZeDRZ3ELpM0iJU7khzGbCOw
	 c/1F+UtEyfepxM2lK4NCXsKd+aip2m1/WsD+cYQ8oJ1YBsm1Q5FRbO6RYxvW9U0lkN
	 2bj013xIlhI3n2g7CmXyhwjHyOQaQibzLdAdEYOBRCyw8Yrk/EPtZOKbHRTcxjK8RH
	 0s4MeTHrIOsB4+6N17TVFvobxHLpZrydtw8RI95H5lBBeqojOoE1uubeLnNP+OWd/Y
	 UrlIP/ji3feRQ6HEShrWmz52K5AcEEhOdqpu08qdrARDZTjFIgmnvq5YXwkcrloe8D
	 01U+zv5KgMiaQ==
Message-ID: <36ccc325-47fd-7ba8-9643-f489495510a6@kernel.org>
Date: Tue, 14 Feb 2023 22:42:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] erofs: avoid tagged pointers to mark sync
 decompression
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
 <20230204093040.97967-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230204093040.97967-2-hsiangkao@linux.alibaba.com>
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

On 2023/2/4 17:30, Gao Xiang wrote:
> We could just use a boolean in z_erofs_decompressqueue for sync
> decompression to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

