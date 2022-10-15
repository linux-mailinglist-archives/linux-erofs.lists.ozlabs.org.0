Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476255FF81A
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Oct 2022 04:51:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mq77Y0c4gz3c7H
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Oct 2022 13:51:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VaFp1o9j;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VaFp1o9j;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mq77T0Wg0z2yn3
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Oct 2022 13:51:33 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 45A6E61CAE;
	Sat, 15 Oct 2022 02:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC641C433B5;
	Sat, 15 Oct 2022 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665802290;
	bh=VUzYc7vln6MW5boe7TlZjCsMEETvQw6gIcTI5Irv10A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VaFp1o9jeNsXGBtWMuHkRhPSAuNTk6/BP2W0Rx5ssqxsgj1GOctx9A2eRcGfDTCzF
	 oz5kIAulDIIUpSO2i4NlsXq/slKVuaoMtrvcJXOkUIfRM06DL7+7WBZWuLLfvnUjMC
	 Rt7h0Fdx/DDRkwj4jIGSwKEV9Ldq51L3PD99fn5tqroqRA/5fBJ0rojLNBPfQKL4Fk
	 mCgiZMtCMCJYoO6EKimEnXvD6hDxCNCFXim+mNwSN8ReUM/EgbZ0nS+0Ca9jiyLTTy
	 ST2bSmXV46AVAoFumYEK7WQkA6vV+u6ZOEr9HVVbIppV16xm9VIyWi7yOmSNrjpngi
	 t785Bnw/RMOTg==
Message-ID: <48b98130-4ebb-61b9-85fc-58d49aa9de88@kernel.org>
Date: Sat, 15 Oct 2022 10:51:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] erofs: fix up inplace decompression success rate
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20221014064915.8103-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221014064915.8103-1-hsiangkao@linux.alibaba.com>
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

On 2022/10/14 14:49, Gao Xiang wrote:
> Partial decompression should be checked after updating length.
> It's a new regression when introducing multi-reference pclusters.
> 
> Fixes: 2bfab9c0edac ("erofs: record the longest decompressed size in this round")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
