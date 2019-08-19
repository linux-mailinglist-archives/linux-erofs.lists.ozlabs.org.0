Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41391A64
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 02:09:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BZ6964fGzDr8N
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 10:09:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="yMDzE2vs"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BZ655brhzDr7b
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2019 10:09:01 +1000 (AEST)
Received: from localhost (unknown [40.117.208.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4066721852;
 Mon, 19 Aug 2019 00:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566173338;
 bh=kTo2k4ONgg3EuE7wELA2Au0DQnnFjpZpeCiBWidAmhc=;
 h=Date:From:To:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
 b=yMDzE2vsNqVt80Q1E/kBrKQEF4MYA8lhpma1b3cz1fl7t2Dn8TcgmkH4dFmK9yth6
 ZcmJ4aIJW2nfvX1uHPZ51OLqdXxOLer3xsmlFdi/xFXOxm3uqOHdMjLV7mHxCJwzbL
 a5dGsS8NYpjZAPX5YNGIZqsyweO8UaFCil+fGmjI=
Date: Mon, 19 Aug 2019 00:08:57 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Gao Xiang <hsiangkao@aol.com>
To: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Richard Weinberger <richard@nod.at>,
Subject: Re: [PATCH v4] staging: erofs: fix an error handling in
 erofs_readdir()
In-Reply-To: <20190818125457.25906-1-hsiangkao@aol.com>
References: <20190818125457.25906-1-hsiangkao@aol.com>
Message-Id: <20190819000858.4066721852@mail.kernel.org>
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
Cc: , linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 3aa8ec716e52 staging: erofs: add directory operations.

The bot has tested the following trees: v5.2.9, v4.19.67.

v5.2.9: Build failed! Errors:
    drivers/staging/erofs/dir.c:109:11: error: ‘EFSCORRUPTED’ undeclared (first use in this function); did you mean ‘FS_NRSUPER’?

v4.19.67: Build failed! Errors:
    drivers/staging/erofs/dir.c:109:11: error: ‘EFSCORRUPTED’ undeclared (first use in this function); did you mean ‘FS_NRSUPER’?


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

--
Thanks,
Sasha
