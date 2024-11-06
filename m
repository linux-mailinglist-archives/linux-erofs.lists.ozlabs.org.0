Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738F9BE9B5
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:36:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4T544CNz3bkP
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:36:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896600;
	cv=none; b=VJYNZVR2z/3n+oQV+9fqosxxzNyrMUyYM3j1Qu5xzIMDUmlHGviZWXxQiFe6zhUdf1kK1zqA59rcpdqG4zEfUVeDV0vk5SWif4OWQLypxDDvl/XbTRPhsQXVtSxtoZ/Jxfp8HtxsLLu9IvpW3rMeVCdL6omUt3uRBO0HXkdgOH0MSz0pdLquTaQb87rUsaqYBSYgdDrzsGv+YUNyDws/P5KObUf9X3dMlYjvE3Q3BhTnrloauAwK7yOo+m24E/n1CSi5a1cqXBYRwEEJl04qQ2+EGT69QAFnXrwP7JrB1AiJcsYIT9QsJO4c1GSgYDfKheK2Gt3fXDPhJzpkWPz17A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896600; c=relaxed/relaxed;
	bh=SueMPOdHep9t3PCuklU6bVWhougpE6WyFc4wdjmYJYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEbBz3Pa1Kn+C1nBvj4IFNX+CAO3HNfjL2tbL1QEnI/GKMdlsEN9a/hiqC0yheiXJxnhGvaZbu3BdqGL+9WrjKCY3izi51KNBEf+slidAUrKeWXcATD6AV/dkXlWyZjHfQfiLudag0mtPBOp2WWl0y8mXZnIe9ynE31j7xhxnQKo8HVO/bEC3Ik1aJcIFbEiDH9NBccPRViBVh9dOGb84iCIfk6suATWjCOrcBqKXeqHmNj86ggLLG2CHEjsKWDu7j38iLsi7hsUCkJ74qBZLl15MnNJf0BAoeElB3nuTV0k9QuFKghanELoUpSdMVMQgmK7+w8Xar48OT+WiaCv7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTsjZCPX; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTsjZCPX; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTsjZCPX;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTsjZCPX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4T312Pxz3bcV
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:36:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SueMPOdHep9t3PCuklU6bVWhougpE6WyFc4wdjmYJYc=;
	b=ZTsjZCPXq0ls55OgDzWqztYeKXO+EIlli9Ov8z3yTAHPAqMejXiicLO0Lvr/e+PIIzzlKE
	P3lJg/nrBN6WswN+JCn8EITrPjDWEMg1lNeJ74YfEGi/ti52FFHN9XGbrUfVMaKIdf7IXJ
	3MjoyiMbOJbgZVzaDoVIeMpua9t3Z24=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SueMPOdHep9t3PCuklU6bVWhougpE6WyFc4wdjmYJYc=;
	b=ZTsjZCPXq0ls55OgDzWqztYeKXO+EIlli9Ov8z3yTAHPAqMejXiicLO0Lvr/e+PIIzzlKE
	P3lJg/nrBN6WswN+JCn8EITrPjDWEMg1lNeJ74YfEGi/ti52FFHN9XGbrUfVMaKIdf7IXJ
	3MjoyiMbOJbgZVzaDoVIeMpua9t3Z24=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-0fAV0xeSNeenkY30paF-Ug-1; Wed,
 06 Nov 2024 07:36:32 -0500
X-MC-Unique: 0fAV0xeSNeenkY30paF-Ug-1
X-Mimecast-MFC-AGG-ID: 0fAV0xeSNeenkY30paF-Ug
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 055B6195608F;
	Wed,  6 Nov 2024 12:36:29 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C865195607C;
	Wed,  6 Nov 2024 12:36:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 02/33] netfs: Remove call to folio_index()
Date: Wed,  6 Nov 2024 12:35:26 +0000
Message-ID: <20241106123559.724888-3-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Christian Brauner <brauner@kernel.org>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Calling folio_index() is pointless overhead; directly dereferencing
folio->index is fine.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20241005182307.3190401-2-willy@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/trace/events/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 69975c9c6823..bf511bca896e 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -450,7 +450,7 @@ TRACE_EVENT(netfs_folio,
 		    struct address_space *__m = READ_ONCE(folio->mapping);
 		    __entry->ino = __m ? __m->host->i_ino : 0;
 		    __entry->why = why;
-		    __entry->index = folio_index(folio);
+		    __entry->index = folio->index;
 		    __entry->nr = folio_nr_pages(folio);
 			   ),
 

