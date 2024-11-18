Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FAA9D157A
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Nov 2024 17:39:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsYJ01RbZz3bcX
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 03:39:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731947982;
	cv=none; b=fvEKRuQKuXlFI0rsFs93dZT40azfWuZW807QU5IRE8SBzPAsR38/FPdr6xCyaCH/xyBOlpM+uYtL2Z6xyFsxf+TRRRzODIcCWvnZPCFF0IcjXdTG/esj4Kzr58y/HWkSPXeNO3GXA1oq2/Ejcfcc/W8CRJyxNf/KjhlGmPLLtUPaIBylxkt9Qe5UgM1TGqArLp5hEtNUOVQuZsagIGd/0AUzlmWGx0qFZY7NkWeNbwHNrO+7nryWd/AD6xPbADhjqhNLaj3ZnHIwfqagh7p2XUWLoQr7VstKCdbWts3+g6XdJsln9wwyfa50E2jG1IcCm5+Wz6y9Oq65d/W7ORw8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731947982; c=relaxed/relaxed;
	bh=5TBgXpcOkE91KJWIrvCU0ksBJeSHSjTfC1vv3ct4vww=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=jmTnfq/5lxXlAyR4WwXjG+MOmhRZLDX/EaLpMMVMdxIXFnI9/wI6EBbpF4LGxABYRth4tRL3CjjRcUC0SK5tfwWT6HJdtzBtlzb8PO6D9FUSxUYXPN9Urg/Z1pBZHABxK8KNK8iMKaK/hGJ9MAiiQN6LeFEamV36CY3/2n15qHTN0S7oTC1JvcLZkUTlKgTJDacm3P2/M7yF8yB5aDxpTWfZAnm4peZatpvDDmL02K/Rv5SawbdXMb5ibnNHzRtBA8uBicj/uWQizuYEMIviGP+MziObk5+tfw9lpGezx1GkOR8cjX0EnY9Lbq2rjN63J0GiuaYg0XXBr0ISnQRY+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FAYvSFxp; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZDWzewrN; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FAYvSFxp;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZDWzewrN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XsYHw6zFmz2yWr
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2024 03:39:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731947976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TBgXpcOkE91KJWIrvCU0ksBJeSHSjTfC1vv3ct4vww=;
	b=FAYvSFxpk4Tl7m9G+xpiVJYP820uAbRAfMzL4D613zvhwZfnkzxBryKzW8bkGv4xzg1oes
	k4NWXshA2Dfj8zRWL49zEisZ/SpHsARW9dAfwsa05NOv+IK5tEnViyb9uR2cFAMF4CzTo9
	3DzVtBsMDA5lNyLO6zEKNMrdOvz4734=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731947977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TBgXpcOkE91KJWIrvCU0ksBJeSHSjTfC1vv3ct4vww=;
	b=ZDWzewrNtx0KzIpfCm/qCvWA0oXI5vw4dwRU52IzpVQ3dKoNBfZ2L06+RmY73m8L4nNcbO
	gUPZmdCqisqaXw+f1/14R7I2PDYBWyVmoV6zrh5rNEYRX5wodsPUvk/BjQwPR59PuQT3vu
	cNB1rnXLywP/EM8CfrjOyJBhO4hoqHs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-r1Nbp_NqPiyaaS_1Yh73TA-1; Mon,
 18 Nov 2024 11:39:32 -0500
X-MC-Unique: r1Nbp_NqPiyaaS_1Yh73TA-1
X-Mimecast-MFC-AGG-ID: r1Nbp_NqPiyaaS_1Yh73TA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6604A19560BA;
	Mon, 18 Nov 2024 16:39:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E035195607C;
	Mon, 18 Nov 2024 16:39:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b7135da8-a04f-48ec-957f-09542178b861@ijzerbout.nl>
References: <b7135da8-a04f-48ec-957f-09542178b861@ijzerbout.nl> <20241108173236.1382366-1-dhowells@redhat.com> <20241108173236.1382366-8-dhowells@redhat.com>
To: Kees Bakker <kees@ijzerbout.nl>
Subject: Re: [PATCH v4 07/33] netfs: Abstract out a rolling folio buffer implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <941711.1731947960.1@warthog.procyon.org.uk>
Date: Mon, 18 Nov 2024 16:39:20 +0000
Message-ID: <941712.1731947960@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Kees Bakker <kees@ijzerbout.nl> wrote:

> > +		wreq->buffer.iter = wreq->buffer.iter;
> Is this correct, an assignment to itself?

That should just be removed.  Both branches of the preceding if-statement set
it.

David

