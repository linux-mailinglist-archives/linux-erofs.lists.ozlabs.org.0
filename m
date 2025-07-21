Return-Path: <linux-erofs+bounces-687-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 184BEB0C052
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 11:29:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blw8T0C2xz2xS2;
	Mon, 21 Jul 2025 19:29:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753090168;
	cv=none; b=MEa7iJuxQpTfqXRX6VzL4D7OgtRSXIuZBQnIz/MGarGy94Bx68PNy9ETW0RE1dXx7ZI3mEZhc7lyG2WITzAC5hmK3Sv0feRND/WOYP6JLFPkMUMiibzjGX80+TNaVL/YCZxMcWbxCjsMBpZJwEqJaJy1YpZZm85FrDfgZaP/O8agS55dE7taOnySjP9wv3V0fGkWwssmpc1I/HRgLprloFQG1cqSSrZ8KqbwXJlM/36pLSdD32R30vjcAnAGREUfHl52oE+Ao7Xw95JyCBWmRRTRm3waTkPLsl0Uma4OmgsDHsb91xIQ8oWICJwvu9XegP3sw0DWdq6FCm2mDLnY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753090168; c=relaxed/relaxed;
	bh=P7hzKQ/AUOqVuvGZfgUv+EifATlVwALDFQzAEjnT5Tc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E1OHnUsyKhS90wCMwp1YkrwNhNzcnf2Ht4QE03WxGo2bXD2QRZROBhQWPKtTinTSRXUFsX5kls+k8c5L06REyoYgxKBDICslnjGlYnWri84oG7gMZH1E0kA8qjpJz3iFOfV2CSfgsxESJr/E/7Qzo4uhe1ccSWpffbp8WNxGtzlkfmkRi/wlXU0ak5y6ENSOe+VQaB78ht8SLAHAsNJ9/Se/hTxChEhmhrM7N2KVADDixmNrZB5QuycWn0uEq5aqNIIIpaVlIodrInM9DXYATG6EvV72PRgCIEG30702Yl8pNKQ6tclaMliiwoF9m6JFqk+iSPHuSV3tUztp8i3WwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g1uxGS41; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g1uxGS41;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blw8S34Jzz2xHY
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 19:29:28 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E09D9A52849;
	Mon, 21 Jul 2025 09:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F210C4CEF1;
	Mon, 21 Jul 2025 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753090165;
	bh=dSHvmJ7mbIS5KasPwwUPeZlFBFSMCYHiOvHBW84+ptE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=g1uxGS410mdQwGvjQTs4rGmq/G1SuyJTRQyjAbyZUz6e88K62W1ra8PVSR8Kfaci/
	 uf+9qO+vNOtZTHQqClufBXJq9orgXSsXyRA/FYN8A+gBiOS3A1s4zdHJHB4pY54k9c
	 nm1fyjj/GW+Zozyj80ReKoejBC73/3unLcLILrSQ1JT2wc3kFmYTF6hqkgzZ+I9JYo
	 Tk1bQaGJ5kPyEgR5OQ5XSLjjjytlH9G9wEw/ySBogoWCLbs0duYLuzMsGy9PUbpfSJ
	 qaRDTzjhqyzPBci7Yubu/PKn8I+dZQPutNyQH54XxmJI3PBpg5An0fpXRBfoAx2s8z
	 MGwhJCXvqTRRQ==
Message-ID: <fadcc64f-d95d-4902-ae4f-981c91babed6@kernel.org>
Date: Mon, 21 Jul 2025 17:29:22 +0800
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
 Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH v6 2/2] erofs: implement metadata compression
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250717070804.1446345-3-hsiangkao@linux.alibaba.com>
 <20250718031942.3052585-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250718031942.3052585-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/18/25 11:19, Gao Xiang wrote:
> From: Bo Liu <liubo03@inspur.com>
> 
> Thanks to the meta buffer infrastructure, metadata-compressed inodes are
> just read from the metabox inode instead of the blockdevice (or backing
> file) inode.
> 
> The same is true for shared extended attributes.
> 
> When metadata compression is enabled, inode numbers are divided from
> on-disk NIDs because of non-LTS 32-bit application compatibility.
> 
> Co-developed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

