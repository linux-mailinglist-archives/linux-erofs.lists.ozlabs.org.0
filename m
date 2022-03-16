Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 247364DA8A8
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 03:52:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJFFH0dM6z308F
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 13:52:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tKWDHvKM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tKWDHvKM; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJFF91wZHz2xtb
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 13:52:45 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 28D70CE1C83;
 Wed, 16 Mar 2022 02:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB39C340E8;
 Wed, 16 Mar 2022 02:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647399160;
 bh=vHF98M61qDvZvLd0Uk5WVb7MVf1iLXSrASw3qtRoIVA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tKWDHvKMbSHVF8CZ8BI+lhJz11QXYzyz+gaRMKP15LiGXLPghlXr+9lFvUU0LLzMs
 VWBNwJk3KRWDCYGGfocp9nmOf5YL0P79iBeFzU9OCcnKSLArB0mrEsbUDxAyJsZEKc
 OfbuVZtm4qEnMYL2suTqFDhx5WL60VEJkt1EU3Y6yXDp6HAkMnPlfox2G3w3LmCdJI
 nc2qDun6fA7DEK17fAD2BtJR2nBGBHw6UDjnJHEIwb1OGFjpuhpLfVthObtv/LLY+8
 zkGneSGTfyBtlNICyAoSYG4fmbeqxAWQT3Q958y1SIf0395zlc5jlFKN0ZHGANmEhi
 JNf6sgkDFgL3g==
Message-ID: <e3611a21-cbed-74c4-e596-e0e628de9b70@kernel.org>
Date: Wed, 16 Mar 2022 10:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] erofs: support read directory inodes with metabuf
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/16 9:22, Gao Xiang wrote:
> Previously, directory inodes are directly handled with page cache
> interfaces.
> 
> In order to support sub-page directory blocks and folios, let's
> convert them into the latest metabuf infrastructure as well and
> this patch addresses the readdir case first.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
