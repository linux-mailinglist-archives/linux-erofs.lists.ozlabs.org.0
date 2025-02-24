Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F484A41F51
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 13:41:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1gMK424Vz306S
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 23:41:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740400859;
	cv=none; b=MeNzQ9x+GbCLMfW0Xu3x3l31eavUwiFB69R6R1KfyNryJsATYFLN4XIFvNCzNmaJJymNzWCA+ZkWDtu0tzv9aKZLavgqeYZXJHRRW8395BoM+5F0vE8bsJToygIO0v+YEJQxOykOwZwiz40/0FCkgf2aJQWZLfCsuvsLoYng8EJ+wFtj2OhQ9BFdtgghBI/myjodoytjtFCkQy6XVVeO50Cche5P7xKLdftfkc15tLApGeDU54ykJfiXf6EjbuWUBqZK6FkXXUhmdcCIurieglvtbnit8+JLtApD1b9YnR5KvsQ0S3YCnkwwfm/kwuDlhXz+ejlheVkKq8ly9rnR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740400859; c=relaxed/relaxed;
	bh=JdoIXR/PyO0tsr8CSMm0YjmkZsBotehPGDdTTTCKsR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCJ9u5FheI+kaFDAlVcB6ejVsUxqZJz/DeIlmaWUZ7q3rK9Ob9IvvVBAsrxfVCSHkEa6S46Ylh0MXURIgFG6TCrvVRcqhe25Gk+N2vqw8Qe7rr00030Ey1yswUAjByuU+u0EBKczdEdpNgMOehMZh385Pi24SAh3uqKFZ5iP1hVI3kS1/HEABTikCDUC9Ac3wLQm48/3Xech0kK3hjxI1+cWWpi0cIiD/NVj2qfu4wJEM4tWge7Yu5olmcdpHj9ReMJkOFRkSlf/h0xrcg+8USoDg969C9QOj7STRi2noW24V5FuEb1ma+xCH8gDkQa4US+Xbvlv2THLmdW7DRS+Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J8zzRuUm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J8zzRuUm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1gMH06rMz3029
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Feb 2025 23:40:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740400855; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JdoIXR/PyO0tsr8CSMm0YjmkZsBotehPGDdTTTCKsR0=;
	b=J8zzRuUmBDsVYfaNb7eZl2Ffs7t7caNa3sjyntrQ/Mn258To+yajugx2gpdwA3YtU4b1eHYICprbkc0TFMRlOI5moe41Xm9Rxe9MGRUcB5GdJTfXAVcpS/Any1GCDncjF1hAXnrhyesRumbrD2kbltKBrSt6j0R2/4W8tXFNhNE=
Received: from 30.74.129.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQ7w-07_1740400853 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 20:40:53 +0800
Message-ID: <26db55bd-31a1-4fb8-8ac1-add64c971841@linux.alibaba.com>
Date: Mon, 24 Feb 2025 20:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] erofs: simplify tail inline pcluster handling
To: linux-erofs@lists.ozlabs.org
References: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.0
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/24 20:37, Gao Xiang wrote:
> Commit ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline
> support") introduced the flag `Z_EROFS_ADVISE_INLINE_PCLUSTER`, which is
> redundant because `h_idata_size != 0` serves the same purpose.
> 
> Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
> features are mutually exclusive for a given inode.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> new patch.

Note that `Z_EROFS_ADVISE_INLINE_PCLUSTER` now is left for
the compatibility purposes, only `mkfs.erofs` uses it in
the future.

Thanks,
Gao Xiang
