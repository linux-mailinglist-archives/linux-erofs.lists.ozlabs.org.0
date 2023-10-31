Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F757DCAD5
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 11:30:11 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fC2f98N9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SKRGm6W7fz3c5Y
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 21:30:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fC2f98N9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SKRGf2mRBz2yVh
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Oct 2023 21:30:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C2602B80ECE;
	Tue, 31 Oct 2023 10:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BF2C433C8;
	Tue, 31 Oct 2023 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698748198;
	bh=2ve8baLNLJx1j/DE/18O2xVsUvR0jKzzYfVZElQOVg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fC2f98N9B/E/C5ZWiobhoexBLUU/nOZA6/4Fwumqon44CfQeKTplbvPOSpsWcGXE5
	 j6GKWNzd/yIucMGlkfpo3fHNpjX0FSlVVGF9JA1XJfH7dxa1npm7dICwOCHf9eeLZ/
	 IxPcK1GeDsRUEg+R/d7Ko9Hl58/zQ/pHzb4/Kix5F04XpDe27nKf0l7XsaJNgunvaP
	 fm22n78oLz2ZZ3CoXokOsFiSKMY9F5JY2mzwyUHhngo3/ktHgpkXhV0rhit27Tbu+K
	 sQxIVcs9M/Xxg2O3bb25SMtIhHs4219c/PgoR++6XcdATSmXrSC1754KK5UdKOF71j
	 BZPPKLihbwtWg==
Message-ID: <c962f0be-c82d-51a8-6b74-4a61e40048b7@kernel.org>
Date: Tue, 31 Oct 2023 18:29:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix erofs_insert_workgroup() lockref usage
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
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

On 2023/10/31 14:05, Gao Xiang wrote:
> As Linus pointed out [1], lockref_put_return() is fundamentally
> designed to be something that can fail.  It behaves as a fastpath-only
> thing, and the failure case needs to be handled anyway.
> 
> Actually, since the new pcluster was just allocated without being
> populated, it won't be accessed by others until it is inserted into
> XArray, so lockref helpers are actually unneeded here.
> 
> Let's just set the proper reference count on initializing.
> 
> [1] https://lore.kernel.org/r/CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com
> Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
