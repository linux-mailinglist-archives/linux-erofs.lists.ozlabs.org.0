Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 069466B2805
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 15:58:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXXPn0m60z3cdB
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 01:58:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GkWzvRMe;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GkWzvRMe;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXXPk2kZCz3cMr
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 01:58:50 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id CC53EB81F6E;
	Thu,  9 Mar 2023 14:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AD1C4339B;
	Thu,  9 Mar 2023 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678373926;
	bh=Fy0PF86k2flygl/jQKs8YcT3wCcxTvDaDOd0+8NdcO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkWzvRMehyETFrkEcTAfT0uE2WbV9L213ExoUmXZQQ91gdUEpJ3gg/nYrV07IyA65
	 VKEcUkToUjEJs3VEaeMQAlAqLpecmigMbaBrAYwuUNoDxcKPyiuLuTnLck40w2C+fk
	 ij1/NUAXURRALcEOmYjejuxgLeV6yM0JAKZY7fcFsqU1f2n5XXr7QLQmN2GeGVq7pI
	 gpgdYGj5csLnBzSr85iWtWqt93nxtnPS2X9qxekurHfW7D1vVi6IkPOfG/oD+1JNt+
	 vJ/iIqn0PbsgN5WA+HE3caFzXrp7joz+12zp8dh/ZvZF/PgWyBZkmA+Fs7XwUIQ5Z+
	 cr7IRPS+GC0sg==
Date: Thu, 9 Mar 2023 15:58:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH v2 1/5] fs: add i_blockmask()
Message-ID: <20230309145838.pgkkkhp4ahvqdkv5@wittgenstein>
References: <20230309124035.15820-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309124035.15820-1-frank.li@vivo.com>
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
Cc: tytso@mit.edu, agruenba@redhat.com, joseph.qi@linux.alibaba.com, mark@fasheh.com, linux-kernel@vger.kernel.org, cluster-devel@redhat.com, rpeterso@redhat.com, huyue2@coolpad.com, adilger.kernel@dilger.ca, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Mar 09, 2023 at 08:40:31PM +0800, Yangtao Li wrote:
> Introduce i_blockmask() to simplify code, which replace
> (i_blocksize(node) - 1). Like done in commit
> 93407472a21b("fs: add i_blocksize()").
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Looks good but did you forget to convert fs/remap_range.c by any chance?

static int generic_remap_check_len(struct inode *inode_in,
                                   struct inode *inode_out,
                                   loff_t pos_out,
                                   loff_t *len,
                                   unsigned int remap_flags)
{
        u64 blkmask = i_blocksize(inode_in) - 1;
