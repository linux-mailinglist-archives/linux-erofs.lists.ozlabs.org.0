Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8614270D3DA
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 08:20:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQPLP2CRKz3cNJ
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 16:19:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RkChh1nR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RkChh1nR;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQPLJ51WGz3btQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 16:19:52 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7E9AB62571;
	Tue, 23 May 2023 06:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72211C433EF;
	Tue, 23 May 2023 06:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684822789;
	bh=KAVEqt/JEohCVjW0sfFZBs2E7jSKgH4ZExSL2rRnJAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RkChh1nRR4XlzI5dz24Hqt59N6RTFlEQXytCmNL9YEZsM/KhIgwR1LRC0pQJlUNNs
	 64ihtB8stMuIt/XiOZNQIB/carbXmWibAIAX/K33ptqF+X2KRx8qDNkuGrgmmQEht9
	 EHXyyzZ+dGwFQYTmB9UxufWmi5PJYhngfvRBG2z52C9FNRI+yIcYlQmrJiirFDJDUy
	 Gh9Le41b1nHwcyGIKuHID3in3tYB7BNwEnavhM+Z5PGvVeCgJ6QVCzpxWDb29kNVOc
	 YJ8tfVvev3Ui7ItwVpze18qSxFXqlQRYlVPo+E4QPKtRDl/gvNvkMXFQTisaaA+foG
	 KU+0qxcdUmZJg==
Message-ID: <b183ca8b-7292-7d6c-e267-0e10bd32ba8c@kernel.org>
Date: Tue, 23 May 2023 14:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP
 is off
Content-Language: en-US
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230515095758.10391-1-zbestahu@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230515095758.10391-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/5/15 17:57, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The function of pcpubuf.c is just for low-latency decompression
> algorithms (e.g. lz4).
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
