Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B323095C097
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 00:07:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqckW3fsYz2ynj
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 08:07:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724364429;
	cv=none; b=W1cYuXj2gHKnZ5IQSEIjXNy22dCMyxO7towPZ6guP1drDu+nGoTC5IgaRaqJRJuVNrUNSPNZoGtSe49+7xXGyjWgzfEaTuYpkxigDMEpuJbno403y8Va9HxqBXktDuSfw/OqeBq0qtAPHf/BnH1v7740irnWZZ4cUkQMSCIzGm0pUPvxXlLzxZmMxAeKFTLI5KeWJNqM/cpqC7p6p2yyOib9Fk1wDNrYef/9hBDXhcQSCSK1WdN4KQsVUu7K+9Bk+NjrweFjMjrOzQAmJ/Hc92Fx3rz00gX7PqByaMKkGMv6II/+gQe+uEsbRKTCZ74Zi9S5smPdKZFoDvab97LbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724364429; c=relaxed/relaxed;
	bh=kxWA4xqBbcQ0SKYTS5195o7goMEsBuv2jCniBGikgOg=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=hOlDDbV3V+GEwiXGUG8I0GAWId8OiwXk4NwwpWUEFq8XCNV+i//cm0BhNiOi5FwzbeWLMvj0m43SyAefCsbRprJkeZ05/Al0uD8CUo+hu/mqACei0V5vv4RhRSdkOihWtHRuSmFT7NjoKUX6y3tIC+3LeFryTnOteXes2hqE+h6yk8MoT00IsGF1AXzuwxC49Vx8KQvwNz0Sc5ukgVBK7AbK4aDCbNopw+195sRaV/fMSoOooPOSXjLORn3uN+1LrZx5jSHBbbgl9PBjNj+mWjJvhvAZG3OUVar6ILqNLjM175ivCwANBsb5iQHYjiTBW0Kuy803IhirM3MFIvBZ9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gF8Lz+6u; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z8KBRnAk; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gF8Lz+6u;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z8KBRnAk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WqckP3Tqhz2xPZ
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Aug 2024 08:07:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724364424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kxWA4xqBbcQ0SKYTS5195o7goMEsBuv2jCniBGikgOg=;
	b=gF8Lz+6usJwCFj8na1ht7OsK9e1TzW3MwU4JEOXCnBaIEY7y68ifgVspNJrpA4aTSw8lWu
	6Rk8sovTbSObo5Wcr2aGGGdwO5rqjn7z/EvL2sgkPhTQ5lTNCY5MgSSamnIhb+OgW6AcSu
	BRyhBzf+82zmR+Qbw0UV/zruzuRoc7M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724364425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kxWA4xqBbcQ0SKYTS5195o7goMEsBuv2jCniBGikgOg=;
	b=Z8KBRnAknN0QsELLa8X93f21dgycmGIVVhkGIYgssLTIjy0SCehh7R5hvbrG7AsUa9LZ/W
	N31S5A8+/J8XxrnZMmry7Vy/cghzI8c9M6gav/gNw1T3BOi5hWbu5BrdCBus8pf8bzSKib
	KJ4PQvkPjGlzf0Xv86Unubi+FRxASsY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-VBKT_YO7Mp2TNuZc4LfykA-1; Thu,
 22 Aug 2024 18:07:01 -0400
X-MC-Unique: VBKT_YO7Mp2TNuZc4LfykA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAE351955F45;
	Thu, 22 Aug 2024 22:06:58 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95CA019560A3;
	Thu, 22 Aug 2024 22:06:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/2] netfs, cifs: DIO read and read-retry fixes
Date: Thu, 22 Aug 2024 23:06:47 +0100
Message-ID: <20240822220650.318774-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian, Steve,

Here are a couple of fixes to DIO read handling and the retrying of reads,
particularly in relation to cifs.

 (1) Fix the missing credit renegotiation in cifs on the retrying of reads.
     The credits we had ended with the original read (or the last retry)
     and to perform a new read we need more credits otherwise the server
     can reject our read with EINVAL.

 (2) Fix the handling of short DIO reads to avoid ENODATA when the read
     retry tries to access a portion of the file after the EOF.

These were both accessible by simply trying to do a DIO read of a remote
file where the read was larger than the file.

Note that (2) might also apply to other netfslib-using filesystems.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (2):
  cifs: Fix lack of credit renegotiation on read retry
  netfs, cifs: Fix handling of short DIO read

 fs/netfs/io.c            | 19 ++++++++++++------
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 28 ++++++++++++++++++++++----
 fs/smb/client/smb2pdu.c  | 43 +++++++++++++++++++++++++++++-----------
 include/linux/netfs.h    |  1 +
 5 files changed, 70 insertions(+), 22 deletions(-)

