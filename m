Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0740C174081
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Feb 2020 20:46:51 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Tg600FhmzDqgb
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 06:46:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=Ac2eCzsj; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Tg3p5BMBzDqfb
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 06:44:54 +1100 (AEDT)
Received: from localhost (unknown [137.135.114.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 17C3F2469D;
 Fri, 28 Feb 2020 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582919092;
 bh=GtzUOUZfYfso0z7LZO8ZMsfUiy9ROA5jckCwXM3IFRs=;
 h=Date:From:To:To:To:CC:Cc:Subject:In-Reply-To:References:From;
 b=Ac2eCzsjkx3Wj7GkxZ5+28BD5xZsH1d1rE9ULBItjaig54oNFYJdhCBwZ8K42EyP1
 EFYPg22RI0tyqFKA2cXYPnCBkUxBqCqevqPUXscuOwykiHepKNlV2TYrZ3MAp/hY9t
 iVBoDPsfkijYMY/PoNPSa1hJeSotWDdEt4/uliTk=
Date: Fri, 28 Feb 2020 19:44:50 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/3] erofs: correct the remaining shrink objects
In-Reply-To: <20200226081008.86348-1-gaoxiang25@huawei.com>
References: <20200226081008.86348-1-gaoxiang25@huawei.com>
Message-Id: <20200228194452.17C3F2469D@mail.kernel.org>
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: e7e9a307be9d ("staging: erofs: introduce workstation for decompression").

The bot has tested the following trees: v5.5.6, v5.4.22, v4.19.106.

v5.5.6: Build OK!
v5.4.22: Failed to apply! Possible dependencies:
    bda17a4577da ("erofs: remove dead code since managed cache is now built-in")

v4.19.106: Failed to apply! Possible dependencies:
    05f9d4a0c8c4 ("staging: erofs: use the new LZ4_decompress_safe_partial()")
    0a64d62d5399 ("staging: erofs: fixed -Wmissing-prototype warnings by making functions static.")
    14f362b4f405 ("staging: erofs: clean up internal.h")
    152a333a5895 ("staging: erofs: add compacted compression indexes support")
    22fe04a77d10 ("staging: erofs: clean up shrinker stuffs")
    3b423417d0d1 ("staging: erofs: clean up erofs_map_blocks_iter")
    5fb76bb04216 ("staging: erofs: cleanup `z_erofs_vle_normalaccess_readpages'")
    6e78901a9f23 ("staging: erofs: separate erofs_get_meta_page")
    7dd68b147d60 ("staging: erofs: use explicit unsigned int type")
    7fc45dbc938a ("staging: erofs: introduce generic decompression backend")
    89fcd8360e7b ("staging: erofs: change 'unsigned' to 'unsigned int'")
    8be31270362b ("staging: erofs: introduce erofs_grab_bio")
    ab47dd2b0819 ("staging: erofs: cleanup z_erofs_vle_work_{lookup, register}")
    bda17a4577da ("erofs: remove dead code since managed cache is now built-in")
    d1ab82443bed ("staging: erofs: Modify conditional checks")
    e7dfb1cff65b ("staging: erofs: fixed -Wmissing-prototype warnings by moving prototypes to header file.")
    f0950b02a74c ("staging: erofs: Modify coding style alignments")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
