Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C3C97EDAA
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:09:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5xC3Vxhz2yVX
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:09:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104142;
	cv=none; b=PqCzHpnZI3wFFghd8DgcUodTGuu5rQHfBiloCyZU2cK1aoW7vELr+YiOK2UF9n3u1U3f8tqfj1TePql+s6x0mGlyG3MfhtlzmRMebYMx42MDy2+CTSHtE6tyvYrxWnQWlUFkta8hOFqY6cK676I0P5MRQaYvfEC7JHnuHKpeR3IoK9s3xAPE7pUT5DWoQbUO9DCakRq5asyZmSfkv9Ktnn8y0s4gS557rIBIKIsnxa2Dz6SedSNxN0M614q8OxCotmI18gqWI312xzExyQtwxzXWnZbtFaWGpKeKtb9tTLoRq2aWt04fb/cl31cnscBazQlyBafOe9JCuYA898AOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104142; c=relaxed/relaxed;
	bh=Z8v23aDW/AqUoLZapyyeRQboTKixFXScSQEzJQ0mhVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKbkNjer5sWiieqg2G1lCNXjsYm/Gx7KdyYkqV8vHwIpfSRFkx6/kvrK+n4CGUuJGXb/1nSWVXT9U3UCLKxplrRRvyUW4sSsfTCnz6WGC1CBWp+2S9s8LM/jDehT3evy8PuUlTosYpOyY4wA26kFm677voaYxRnqM0DFeKcLeKuBuHzDAE4x6OpkprePQ0dqE9D2Fyuwe6oTH17Dz76wf4MrLEItCaUHB6a61mZVtPttVPjB7LM/6Vkve9BsBMRozpURX3TlYzpn1FwAjeqhOilhjfBf3Hs7zj6wKjQTvyB/E8jaPynQDNgb5pfpvfgflBoZ4HnRP0Oo9ykCna5yZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tc6i0D6f; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tc6i0D6f; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tc6i0D6f;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tc6i0D6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5xB0Z6pz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:09:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8v23aDW/AqUoLZapyyeRQboTKixFXScSQEzJQ0mhVc=;
	b=Tc6i0D6fmvustL66frg53LvbW7Z4gky+jOGR55GwhxYFhAF9hjX1hrsAfxyjRe/6F0v7Ki
	k5FKgz3Fgtm5H3DZrUnCmmXpyLCfK9C3zbJXP8hJvSdu2MBu4atXP2rRd14NOXWf9Bo8nA
	UwxsUXwmIrzaHL9L7KhL0g6y/s0stTs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8v23aDW/AqUoLZapyyeRQboTKixFXScSQEzJQ0mhVc=;
	b=Tc6i0D6fmvustL66frg53LvbW7Z4gky+jOGR55GwhxYFhAF9hjX1hrsAfxyjRe/6F0v7Ki
	k5FKgz3Fgtm5H3DZrUnCmmXpyLCfK9C3zbJXP8hJvSdu2MBu4atXP2rRd14NOXWf9Bo8nA
	UwxsUXwmIrzaHL9L7KhL0g6y/s0stTs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-DYyLGeXsPkSx-Jt_v0ORCQ-1; Mon,
 23 Sep 2024 11:08:53 -0400
X-MC-Unique: DYyLGeXsPkSx-Jt_v0ORCQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAD5618B63DB;
	Mon, 23 Sep 2024 15:08:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C923A1934989;
	Mon, 23 Sep 2024 15:08:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 6/8] afs: Fix the setting of the server responding flag
Date: Mon, 23 Sep 2024 16:07:50 +0100
Message-ID: <20240923150756.902363-7-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In afs_wait_for_operation(), we set transcribe the call responded flag to
the server record that we used after doing the fileserver iteration loop -
but it's possible to exit the loop having had a response from the server
that we've discarded (e.g. it returned an abort or we started receiving
data, but the call didn't complete).

This means that op->server might be NULL, but we don't check that before
attempting to set the server flag.

Fixes: 98f9fda2057b ("afs: Fold the afs_addr_cursor struct in")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 3546b087e791..428721bbe4f6 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -201,7 +201,7 @@ void afs_wait_for_operation(struct afs_operation *op)
 		}
 	}
 
-	if (op->call_responded)
+	if (op->call_responded && op->server)
 		set_bit(AFS_SERVER_FL_RESPONDING, &op->server->flags);
 
 	if (!afs_op_error(op)) {

