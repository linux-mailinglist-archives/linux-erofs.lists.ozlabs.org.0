Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD96A13547
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:28:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737016102;
	bh=1JbwfIAYzFyDAaomYTEyCpNyqxMIy4X4eyDCSk0HLu8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PzGKBOZ0hnn4lqNoNRC2qazNxd/KnLDebx6ouDp+I0UiIMmlCWCzrwhBE/gM6q90O
	 gaHtpmuZAFhxQ451t/5K9JzYBaH/HYYe5gwT5rys4dgC8PFP3AogrdiUGPG1JRd+CZ
	 62DujOaqnb052addFlFF3pqm/S+jIati22wvr5u+kjXUafNq+bYPHrBgp5PhrB7P1d
	 as8o/8PeuyOttSrXE1tlCqeTFr8fVAhmus7Vi2O994puvc2zfMiAFyu2soZCNsAo+H
	 6ocMeqnCRpfRbOy3YswAeHVU79xR3jXBFBezhHUaYlIeA5XD5pWE+mUc1mYaoCKPQj
	 +TFWh+Q8sSAfQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYbbp1R3Mz3bjs
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:28:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737016100;
	cv=none; b=BccvjlaGt/7AeCAV038+rZtos7H+ZGb8ZlEsM4iCFKAfo74rCnU4rWtSeIu8gMz6TLtNab4oNhIvJFJemFfy0lPT4NWD0fyiPgZHPn059SxZRUzH+QuTeRJw6VvpLjNxLJSzqmQTLAYJb7lDEzas5CBtZrQVFDyO8JTVYP6oVidPHlhI94Voj7hQaT/GD4QEAty65Ql7aKxnptvecc5ucJLTdRik/HD3TzvYvT2F2VIBzO0mDM0SYORkhjXdx8VT1576uuUWehfEjKfJA/G0Q+ME4Bttr2vxLSkPWdfKdb/v3PqRqtvnTiislHMQcLycKtcyyGheXU6d8ymokhTmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737016100; c=relaxed/relaxed;
	bh=1JbwfIAYzFyDAaomYTEyCpNyqxMIy4X4eyDCSk0HLu8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HvFkkgVdcK6Fv1ndykpzvYshF/Mx1oL0Nqp+UGgVRrz6P1p63eNzMvabkAvo34zQ6liyec3l6d7Jm09Q/V2TjUpfS8ocqZYQtfPdxkDvsSKV7Jp4RrUE2JG9qcrasIB1HaWwap4e+tEvWRcn2R76GG62xFIe2NuHquLApNFDMzwI4ExU4nj5cXngOGpmYhBPBg5Ghf/DvJ+tR7E9ENKIZ+Q2OLkNRU/UXtGbb4/xs9+mgxYswjD9XpoxztNpH6F08DsJ5/LRktcjQD+vHtO9zyDmevawkEvannD6lnvg7oc15gLBkL+X4Umvr5SIrxlpl/QMTWLGnGoFyoXbxJKEGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iHeoRhPT; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iHeoRhPT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYbbl5Vtlz2ysc
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:28:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A55405C5C8E;
	Thu, 16 Jan 2025 08:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326D3C4CED6;
	Thu, 16 Jan 2025 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737016097;
	bh=7pAdBD+u89J2faE2h+z1zYNtIVQQPHSKPJE0LgQAGcQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iHeoRhPTdLBYaoBiK1GW45QEuiyiLS4qBCiWB7bYFep2RuVMgp+3IkBmqo9by9yw/
	 cVE9o+lNj5z2R9QYzVJ99/Rcym7mkeknJVMtEhA68xxXLkyWf7y7gG79GnxxIzQOft
	 4IB1/yMvg9fAQYAP8WdsyFLGPzJTNFOIr35ramcpC8v74slF0lLYBY56Vww1/o/zT1
	 FTY6B+jPr3dgfaeiXGOD+KLrdFbtsWZF5r5tkhOKfJFKFIoyQ3VI0GHvlE6BteaV7z
	 gH62p6ui/SRtCgVZUSsu/0d49GY1Ajh4fLpxxSIWNm28XCBSdN3CI1ZO31RW5bXmMe
	 i//j71tqv2UGw==
Message-ID: <ff673fda-a226-4b7b-b8fe-aec1ec2fa6be@kernel.org>
Date: Thu, 16 Jan 2025 16:28:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] erofs: micro-optimize superblock checksum
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241212023737.1138989-1-hsiangkao@linux.alibaba.com>
 <20241212023948.1143038-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20241212023948.1143038-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 12/12/24 10:39, Gao Xiang wrote:
> Just verify the remaining unknown on-disk data instead of allocating a
> temporary buffer for the whole superblock and zeroing out the checksum
> field since .magic(EROFS_SUPER_MAGIC_V1) is verified and .checksum(0)
> is fixed.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
