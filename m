Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CC195CC7E
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 14:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724416797;
	bh=fkSO6JL8PT/t58c13PbpvvWXwVCAr2TOUzEK6SQmUmE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oJHu067ysgmIw77JBQj61UIvav2ZHpsd72nW/ZwlhbpyY4YkN1AnSDk6lcgwzktNb
	 k0YHZFERl9eGU1P8ana2OUDmtz0Cxq1BtvphxVcgD/26opUjfmhBBpm2uP3VFbG2zN
	 klsMNY+htyYL2xaffjAe3+h7eLHc9e0fw26j1RHlgxlWvw5e6VFcCoucgkbgoKXXvC
	 Y45CBc9S608zGsxNvL5Tna8vKrnK0BKlfkBXobAxt4a02CPfORzUtm2dqlKrjnVzp+
	 Z4GFTLk6adSBFR2SbonXF20NvXyW+0ubxlsF5LyDeUKRWgKjlGTbhl3Wf06lx5iLLq
	 j/TxsTXIweyjA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wr05T0Xkpz3009
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:39:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:40e1:4800::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724416795;
	cv=none; b=b0bLlR5VTrpR+nNT8tLVScgMAc7gn2A6z0qdE3rQfBAGKwsk+SwyqKnabit3uyvfQmmbkMmFyhsPJzYQmnJ4rXBw/TpEpR8S099sFob//XG5UXxWZkwdaKbKQo29swq49kctENQV1IFO6qzcTakiPy/a8745GTxgccNaLgYDFCEufoGnSR1lUs9qP5YeOTFZi+tcOS3HCUcoiOhwkXwzGqVWhIEaGxMolyTSk3h65S1Ip2F/F5gpkMBwz/G6asbB2OACBtm2lY+8bS59Nbr7pJHq7x2Ak/pQqqHnEYY6Ah2auwfTNkx9ADndMSNDiQKBYkj2Ad6CPPn0RbpFpQ9aeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724416795; c=relaxed/relaxed;
	bh=fkSO6JL8PT/t58c13PbpvvWXwVCAr2TOUzEK6SQmUmE=;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding; b=BNSlTeBZuaZVG3Jy9kn5d+bJ+B507RPIzxsRg+i6vPLvSSWpPdLW38qEA06WNis1OOPlJ1guDC1f9cc1EwLEi6kjhDfpEkFnJI1kwtkNLyUmT3yH9wv+8n5RDu230zsO+7INIMVGK44WJS8bJTNStqRPRdmyG6mllKx9f5BBrtsE64WdVjSp8YSmvRGsoOvkwcYTcv/H3Fb1wNAKQuQS5pwWIx8nMsZyUQqyZAFvkqq7zFtsuUvf17nE1tTgWPGg2TcBlp86tWDbCKG6xHktawt0pb6kZ7sEOdHoRn+tH+71cHhjm9er8mdV4sx/Lbe5NgEOycVdid4x9c2bIoJJeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Tqr7a4k+; dkim-atps=neutral; spf=pass (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Tqr7a4k+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wr05R0hYzz2ywS
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Aug 2024 22:39:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5F62DCE115A;
	Fri, 23 Aug 2024 12:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C2C32786;
	Fri, 23 Aug 2024 12:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724416788;
	bh=OQN7Mf7HQDUQaFApg1+V9RgbCzXwyxIPK7zuLgztQ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tqr7a4k+ccRM4DsoOY2ydy+JCEJZDrohUYfQJAvlzdh5t8ixJwsUBY0DES6Rl/oKr
	 VbmP+9k+07wMjNk+o+6XDCeUoaTgI+jsXsnIn3Y+JR/tF5scYDamudVnGlgnKYE1Zj
	 B9eyNR1aQwtl8u76hHA5tLSIpbqRml4b4IBNw3J2On5pNEYSKjCjIZVWrKKwFhcMIR
	 5IgtarUhZ2Zksg/LALvyQdsi9YCec95qCJzNSZySlA/dzymJPqm59ggAOXaNvY7Q9R
	 cr1VJYKZNJqn/sTSV9L9HnTyWNLdfrm5bUTvSFNM9zUDFDpMCtQLsWpMFM+lFU02tB
	 ay6weNJME3dSA==
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/2] netfs, cifs: DIO read and read-retry fixes
Date: Fri, 23 Aug 2024 14:39:34 +0200
Message-ID: <20240823-relation-offiziell-fda6c4626508@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822220650.318774-1-dhowells@redhat.com>
References: <20240822220650.318774-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=brauner@kernel.org; h=from:subject:message-id; bh=OQN7Mf7HQDUQaFApg1+V9RgbCzXwyxIPK7zuLgztQ10=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaOZRKjvtxCkjtZRpcoliflzLrNA9yto3dz9n4D2cN mNb+YKqjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8bGFkmKibfHdXY2p8D2P7 gt4dxrZNMYKPfzS8Mpxuoqb24KpAIiPD/M//2mKuxJza36Alxn+QTc3k9y63rq8fDFb8+Hsssus eOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 22 Aug 2024 23:06:47 +0100, David Howells wrote:
> Here are a couple of fixes to DIO read handling and the retrying of reads,
> particularly in relation to cifs.
> 
>  (1) Fix the missing credit renegotiation in cifs on the retrying of reads.
>      The credits we had ended with the original read (or the last retry)
>      and to perform a new read we need more credits otherwise the server
>      can reject our read with EINVAL.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] cifs: Fix lack of credit renegotiation on read retry
      https://git.kernel.org/vfs/vfs/c/82d55e76bf2f
[2/2] netfs, cifs: Fix handling of short DIO read
      https://git.kernel.org/vfs/vfs/c/942ad91e2956
