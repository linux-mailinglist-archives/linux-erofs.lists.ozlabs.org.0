Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1411197EDA5
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:08:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5x10Xj1z2yqB
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:08:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104131;
	cv=none; b=hLWth8SgAidHHjVtCG7ss/40sp4GB4LI2cJDMc7tJhGJdrZ35Z2kz86Acq7gS0gdgI98iqEAYtvrMlH3zVjVFJwRMgNXiwHbTWkHN4m8624Qw7pUtl6e0SEXL9/M1nQewDrvoo3Q9uQV9/s/5rd5CpjOq1HpdQdQPbobBRI5CXqBndwXIt3ktooPk0yEt/c/rBbfZ8rJHftKLEZ3wCFfTI1ghFIabZKhN4k2zhYx31wziaWeTN3fvPx17givvIQpdMhUUyZr1blIPkOxVtfRU8s2qZIIeV3+FbVofYOdJ3j7giRg3XXcJslOJ8N6pQjCZ5Bw6z3iJnoLny1fUYaz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104131; c=relaxed/relaxed;
	bh=YHIPIQ0jqmx06tKWg5zwKCYYjtifDx3/S1TSTB/jDJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL4/KpDxN3fHES0aRbaXvxB/c7Ok0e/tsXyegYoHlLps2w5MvbNUplOjetfEuhtOa4LINY0hFl34EeMT3uc4hooBKkQZZ3zvschL7wsYfXaVO0bnyjP0v6rFNkQcn98l/sDqddqENfR9a33AtpcSvn91mJYYsQV778lr84zTKyUxeKODnvQ9tfHlEMIaej6pOtF6JBbZ8Y4qxMehYmdwRBZCk4JbjK1Og6SNx6rlYyK98oZCO+XjFQL10O/rLHvb01+emDm1CeqVPI1cUXkuWxXd3q6k3aiR6Set/0ljB/mKvJT9jlUabJ/Q7uCCEfddMXh3Sygo2fU/s0RUzlzelA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTVKvKy/; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LroY0l+/; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTVKvKy/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LroY0l+/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5wy6VQJz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:08:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHIPIQ0jqmx06tKWg5zwKCYYjtifDx3/S1TSTB/jDJ4=;
	b=PTVKvKy/OpXZy1JmwaKJStZ5BwY/sgZfb9V5qjumC+l/bNLmBbgBAkdVKz9VIzLjiCG7da
	EgzBXUsFJGG3m1X4aiXC8RQHwOIxUbrLHha6iwbdNQSMkSA1wmC2H4Si+DPfvghtQ43fek
	JyrpA5JpW8LP4ZPolkB0F3uoCrO5mGk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHIPIQ0jqmx06tKWg5zwKCYYjtifDx3/S1TSTB/jDJ4=;
	b=LroY0l+/FDtfpnueqIhjMlPVLtV3Zp2jTAJvvLGaif4yKu6WkGbzpRRAzksv55BxL0ZEe7
	vTvqIe9PaaRwxPvCLPUUcUzQQT6gHLoq2cVrVdyBGOreQa/obVRKE6ua96OuxiZTaAeOLs
	t55h7UM578t/4C9t/NFiVXtseSDUom0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-n60o72YoO8em_juxYjNDxw-1; Mon,
 23 Sep 2024 11:08:42 -0400
X-MC-Unique: n60o72YoO8em_juxYjNDxw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 633B218B6A33;
	Mon, 23 Sep 2024 15:08:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2387B190AABA;
	Mon, 23 Sep 2024 15:08:24 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 4/8] afs: Remove unused struct and function prototype
Date: Mon, 23 Sep 2024 16:07:48 +0100
Message-ID: <20240923150756.902363-5-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Thorsten Blum <thorsten.blum@toblux.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Thorsten Blum <thorsten.blum@toblux.com>

The struct afs_address_list and the function prototype
afs_put_address_list() are not used anymore and can be removed. Remove
them.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240911095046.3749-2-thorsten.blum@toblux.com/
---
 fs/afs/afs_vl.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/afs/afs_vl.h b/fs/afs/afs_vl.h
index 9c65ffb8a523..a06296c8827d 100644
--- a/fs/afs/afs_vl.h
+++ b/fs/afs/afs_vl.h
@@ -134,13 +134,4 @@ struct afs_uvldbentry__xdr {
 	__be32			spares9;
 };
 
-struct afs_address_list {
-	refcount_t		usage;
-	unsigned int		version;
-	unsigned int		nr_addrs;
-	struct sockaddr_rxrpc	addrs[];
-};
-
-extern void afs_put_address_list(struct afs_address_list *alist);
-
 #endif /* AFS_VL_H */

