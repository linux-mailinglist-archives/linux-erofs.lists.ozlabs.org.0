Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2710F2B5
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Dec 2019 23:13:24 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47RfWk0G37zDqMr
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2019 09:13:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RhF1YouW"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47RfWc3xy1zDqM3
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2019 09:13:15 +1100 (AEDT)
Received: from localhost (unknown [40.117.208.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8F590206F0;
 Mon,  2 Dec 2019 22:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575324792;
 bh=2qBYdtuz2vsQcjVDzoS1io7b09w1B1yxEg9nyBoL3PU=;
 h=Date:From:To:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
 b=RhF1YouWDdGexwkMc/ASSTZd6L2N+QWk6ePoWA85BRhWHe5Z/GqoSxuaxcggnJK5P
 4/v+J1xunyku09p6eXoshOf6oMWkxAP0SUgsZRfXGJkHqtowVdZiBcF6CP541h7PBn
 4WzWf/FilTBr5iVwJB0s/GWeGlivHuQf4PW2brTM=
Date: Mon, 02 Dec 2019 22:13:11 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Gao Xiang <hsiangkao@aol.com>
To: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs: zero out when listxattr is called with no xattr
In-Reply-To: <20191201084040.29275-1-hsiangkao@aol.com>
References: <20191201084040.29275-1-hsiangkao@aol.com>
Message-Id: <20191202221312.8F590206F0@mail.kernel.org>
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
Cc: , LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: cadf1ccf1b00 ("staging: erofs: add error handling for xattr submodule").

The bot has tested the following trees: v5.4.1, v5.3.14, v4.19.87.

v5.4.1: Build OK!
v5.3.14: Failed to apply! Possible dependencies:
    Unable to calculate

v4.19.87: Failed to apply! Possible dependencies:
    Unable to calculate


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks,
Sasha
