Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7F6E3957
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:36:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pzt652tg9z3cMS
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:36:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jT11b1ZE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jT11b1ZE;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pzt631t2Pz3bhZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:36:11 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 739006115C;
	Sun, 16 Apr 2023 14:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B47C433D2;
	Sun, 16 Apr 2023 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681655768;
	bh=ZyWpvvtl6ausC+L04T+VxmLWEhXr4qGI8K0y/PTwvKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jT11b1ZELErTHW52Xlnjqn0vjBpk0wYfTSqu1b9afDEUfMIrVAwZVd0pTFWnKyiI/
	 ZmOx5sqYbINdXzucXIMMyqZWaSeu3Nz54gr2HEK5A/DDCnIp++f0IczDTllafAmB+v
	 DyBPKFVrIsJTRWtUPVl2F4xeBocfhi6rPIC6/BhXQ9eq87PSF2lDx46ay9tetOVOiT
	 7zEiUgMdFyG7Zh4wMdKnqZcACj+x0zwi8atbXRR8hmrlAL5MbkKGpHe7ofBI14viqh
	 0Qemr3T8EFwPJITZOBnAxXhFvC4h13raljkYbjEmEgP0i9hVSrkkSKROWll08z790h
	 69R9ouhQZdA0A==
Message-ID: <c6c6cce7-7e00-cb31-a3f6-2d3e47098050@kernel.org>
Date: Sun, 16 Apr 2023 22:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] erofs: get rid of z_erofs_fill_inode()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230411101045.35762-1-hsiangkao@linux.alibaba.com>
 <20230413092241.73829-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230413092241.73829-1-hsiangkao@linux.alibaba.com>
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

On 2023/4/13 17:22, Gao Xiang wrote:
> Prior to big pclusters, non-compact compression indexes could have
> empty headers.
> 
> Let's just avoid the legacy path since it can be handled properly
> as a specific compression header with z_erofs_fill_inode_lazy() too.
> 
> Tested with erofs-utils exist versions.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
