Return-Path: <linux-erofs+bounces-3349-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLM5LAc252mg5QEAu9opvQ
	(envelope-from <linux-erofs+bounces-3349-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 10:32:07 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F443831A
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 10:32:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Fvm4wJyz2yrm;
	Tue, 21 Apr 2026 18:32:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776760324;
	cv=none; b=ZjYxwkwJi56T5bjdbkZEMgtwYR5e9bzpGPGzWbbNk56pUC4WXYsjht2vhrijJuSQJ17WdA2kvtVSYLLiu67TDKK2KwVKQU2G4tkLP3DXMGAMa2jleQjuywkywdYDW5puqlCp/CCNMJ9Qv5Cz05Bb59nvypZFkyzkKjBAjrXMu32cN3+GSdN/MclQakjUbc/3A5A8wDns8h70dvFrstPQ04w3iJcd+wsHGZVZvMMRGLqywpopYaxBTjiTKMMiyJTTVdHuiJGaoQxNcsE3s0g4UBTNR6H2D+IigH8c/BTaHnaEtTEdpuLthBs/LQIYdo67+4ED8HShpN+jl9GdRNuiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776760324; c=relaxed/relaxed;
	bh=PtH+wUpL/MLD6obxBXQjux0Sa20AeJZ9ct8OCuUljK0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K2y9BCjewFnL0uOosKsK2E1SgU645etCWD/fuLkNCEIpa7DD2AQtRuC60MUBm6thV4XkwZcC96DHWDFD8cxBaN+Day9xlyOQLQcgGhdpZacobGn3ufDHlkccUZwC0rz16K9DFqZrJtaNm5r4vvwkO66QfITOCQwG+BHY5gEqL3rmkJEujFgaoh6dTKYh5TkuFHBzZHGg/xjoa/Tp7ZDQvn1mPwMr+btUsZ5keHiykguBfWFS+ye9ur0X9dOxF2T3fCtKxf4TV+/ust7teSrMwphJmyfEvhR9zTX3/XNciL69Eg0rNXjqcK1h9OJjN1AWHl0SKUpz491xppvDpn+JPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XSRUhvVE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XSRUhvVE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Fvl5Hsbz2ypk
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 18:32:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0545943B9E;
	Tue, 21 Apr 2026 08:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE92C2BCB5;
	Tue, 21 Apr 2026 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776760321;
	bh=MsUqviCgwVv4hLZvpyZSFEthMC6WAOJaFGnYx96Eb/U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XSRUhvVEpdlQIx5/NNskYUvr5DplRdy9NpgTwtVCadTUYUlZ05VwosFR3Jdby4Mbl
	 vkjRCzK+pun3AvQj3B8rxsgq39lbjzKbUMVSdTkVkh875bKd0SU4lHnqKQCr/PUNvL
	 xSCKF4gEzzwV5scdr+q8izBUqsJlbtfyTBGJMmWJ+tiyc4X2CvQWBzHtlGbGwcOnsc
	 vwWReMr+GkAtSx/qZ8vr/avu2ebeAGECblZF/49BO4aahUkKTkHk55XDQsi9fUhKKB
	 q+xMVu9kMxNw7m2OTdRJ4POwunBq4gssvY0cekEtviXvqeYW2qsOqw7KNLOsoT5Wg5
	 p26t5stHTtbxg==
Message-ID: <4c904b6b-afe9-4ac8-a1d2-47b7c84b67db@kernel.org>
Date: Tue, 21 Apr 2026 16:32:00 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 oliver.yang@linux.alibaba.com, Yuhao Jiang <danisjiang@gmail.com>,
 Junrui Luo <moonafterrain@outlook.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] erofs: fix the out-of-bounds nameoff handling for
 trailing dirents
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
 <20260421075952.975069-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260421075952.975069-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3349-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.alibaba.com,gmail.com,outlook.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,m:stable@vger.kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,outlook.com:email,alibaba.com:email]
X-Rspamd-Queue-Id: C71F443831A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/2026 3:59 PM, Gao Xiang wrote:
> Currently we already have boundary-checks for nameoffs, but the trailing
> dirents are special since the namelens are calculated with strnlen()
> with unchecked nameoffs.
> 
> If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
> maxsize - nameoff can underflow, causing strnlen() to read past the
> directory block.
> 
> nameoff0 should also be verified to be a multiple of
> `sizeof(struct erofs_dirent)` as well [1].
> 
> [1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
> 
> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
> Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

