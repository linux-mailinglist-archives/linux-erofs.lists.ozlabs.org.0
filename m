Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5CA7685AD
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 15:40:35 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=t-8ch.de header.i=@t-8ch.de header.a=rsa-sha256 header.s=mail header.b=oYCE3PKH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDMvP62nMz2yFC
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 23:40:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=t-8ch.de header.i=@t-8ch.de header.a=rsa-sha256 header.s=mail header.b=oYCE3PKH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=t-8ch.de (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=thomas@t-8ch.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 532 seconds by postgrey-1.37 at boromir; Sun, 30 Jul 2023 23:40:28 AEST
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDMvJ3BTPz2y3Y
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jul 2023 23:40:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1690723883; bh=yo4I6s5/JIPLqK8K6k5zbNM/vTwpF+NR0NjfEi911yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYCE3PKH6dTdwp7caJgSksAupi4XvmTaFkgMI9PFU+ZnueloH0T1AZRScEJBD3QSj
	 pTvpAmLgjoc+abV5T8ZhqUqV9QNN6k2r9qv3uCRsuwePmWnS5hYkpe3kmpeJOdMX4c
	 Ab7lPQtG3eUy169iPFFTZWhOWQKFCqk4fRrBtbww=
Date: Sun, 30 Jul 2023 15:31:22 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
Message-ID: <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023-07-17 19:27:03+0800, Jingbo Xu wrote:
> Later we're going to try the self-contained image verification.
> The current superblock checksum feature has quite limited
> functionality, instead, merkle trees can provide better protection
> for image integrity.

The crc32c checksum is also used by libblkid to gain more confidence
in its filesystem detection.
I guess a merkle tree would be much harder to implement.

This is for example used by the mount(8) cli program to allow mounting
of devices without explicitly needing to specify a filesystem.

Note: libblkid tests for EROFS_FEATURE_SB_CSUM so at least it won't
break when the checksum is removed.

> xxhash is also used in the following xattr name filter feature.  It is
> redundant for one filesystem to rely on two hashing algorithms at the
> same time.
> 
> Since the superblock checksum is a compatible feature, just deprecate
> it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> changes since v1:
> - improve commit message (Gao Xiang)
> 
> v1: https://lore.kernel.org/all/20230714033832.111740-1-jefflexu@linux.alibaba.com/
> ---
>  fs/erofs/Kconfig |  1 -
>  fs/erofs/super.c | 44 +++++---------------------------------------
>  2 files changed, 5 insertions(+), 40 deletions(-)

> [..]
