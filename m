Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58204785AEB
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 16:38:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lSMwIz2w;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW83Q0vVcz3c5H
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 00:38:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lSMwIz2w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW83K6P8Fz3bxt
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 00:38:37 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8195663D6;
	Wed, 23 Aug 2023 14:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F69CC433C7;
	Wed, 23 Aug 2023 14:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692801515;
	bh=MiK73TZc2KpjLlp7+OAj1DW1O0IWdMemFhSZ6Aa9Y4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lSMwIz2wlIZc1l5HdvhFFl29xh6p9Duggjx+3IeADNpwisPwCa/L4bWm7WSpdRAih
	 EQb5nIRgiQdzNCa3ICqzhXOXKWMTIQV8xhrvbmar6f8SQqHqG81eY9QYWz4D3/17cn
	 OrUpCeX3G3m26Xm9CTxxFtN1Igfg23kRXZoqxq9N0dQopCzu9C+NRxLGVldHLlsziL
	 gMoAtwpWHySF87iUDJjoWkVamqlw8vuCR9t3SDdMHqsKuelwnODQsiBxiNN4oy232L
	 S/rFq1guO6AnpHgtAHH+ybx8WMRvd274Hj9vewpq/gu6U4hRhTgX5mGzpLpBgmhzE9
	 bErjPlSxEXa1g==
Message-ID: <7434f8ce-6684-c520-b3f6-d85326a01dca@kernel.org>
Date: Wed, 23 Aug 2023 22:38:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] erofs: clean up redundant comment and adjust code
 alignment
Content-Language: en-US
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230815094849.53249-1-mengferry@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230815094849.53249-1-mengferry@linux.alibaba.com>
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

On 2023/8/15 17:48, Ferry Meng wrote:
> Remove some redundant comments in erofs/super.c, and avoid unncessary
> line breaks for cleanup.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
