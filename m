Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98677988B82
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 22:50:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XFjKY1W8lz3cQs
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Sep 2024 06:50:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727470239;
	cv=none; b=YbKn19ECvdVOFBRzSG2M8g+Iy1wMHUxRxR0nwhhcTmhAtIdau6ySfYg5Aev64YVoY12AH1ZDgB9d8cwKfbrzHKfTheeKiXKkh11fGPT+Op81CHK/YoURmkU+ocml9gLv9uGbybJHJoMHGMRTKOobvUj/n6Fx18g1IklD7ReOS2tnwesK+l5di/ynnInINCedbdzt9j7AKj5goT3HaN/AjUWYh9F9JSW8DAJTnJMO2uee0/dZtVLS4+ul9frBt1Llky2n9bubuRb+SmmQ+MucYyboqWrx4SQ18mE8V6pyZEetMRfCmLdJtNaSTjG0h7CoONtIuIQNd3kzMSiKIHWArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727470239; c=relaxed/relaxed;
	bh=Ehr+2NKsngL7ZGsFX4D84MvJxLhbtVlSuY/MGkYSJZ0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Ek1+lH3eerHeW3rKD3ndVleSiWqKdjJo0e+4y6OyWYHmj/3paS9BXpZT2N0/U0C7xGHlgmUuiONINQtBRSDfrrC/xoNarpU/8cNoghZLJpbYM4S8O7QinlKncQ/mFBNEvjz/svO1v8wnyo2SFxa2gns608D2cYV9Ed8bhlj7jEDCt9169JmaWEKDw5eHKZyuwjJVzQvSB8eHoVQGFR+AohpPt72AstJ95jmkbP66ewfU0Vahx/c0M0RedSdfw/1paYOsDIYoaWTVF52/TDKldUaODCHjb0WHZAXQIj2yYrUfjizx76cMvxLsfcEVLkICUICTjgjmQ9fesm1awnmeXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iVo+I93f; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bnXtoIpo; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iVo+I93f;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bnXtoIpo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XFjKW2MSxz3cNl
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Sep 2024 06:50:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727470232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ehr+2NKsngL7ZGsFX4D84MvJxLhbtVlSuY/MGkYSJZ0=;
	b=iVo+I93fBSlhMmLjPrDQhuYtSeelImAKgWINFpq5o/nHvjma5ASXtTZI9+XBtM2TgNNpgY
	sirEjACAJXO8huiTj9ZvOvMaSiYGvxM0TPRhkO1So6NBxwwumpD478z3zUYlVBVAhC/nO8
	nxTfiVteHMW029XLjXFWiWaArb4gukY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727470233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ehr+2NKsngL7ZGsFX4D84MvJxLhbtVlSuY/MGkYSJZ0=;
	b=bnXtoIpoFXcKz0aSC2p++Qqx4NgtPYHpwIAjPe6XJKcua3mFZn9UjSy0aV9SbFusF8Sp28
	D86A/SI37bdPosQsY6FDSjtcjOyFx8WQnCF0DxXN7bke/TeVSKQ26vyS+7EDinAd4ezTEe
	7AOPZ/4JEh+/A6dTIJXetQFsHpnXZ/E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-peQ0JcNLMAKLyO6YtwYCog-1; Fri,
 27 Sep 2024 16:50:27 -0400
X-MC-Unique: peQ0JcNLMAKLyO6YtwYCog-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C38818DEF1D;
	Fri, 27 Sep 2024 20:50:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A0421956086;
	Fri, 27 Sep 2024 20:50:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240923183432.1876750-1-chantr4@gmail.com>
References: <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com>
To: Manu Bretelle <chantr4@gmail.com>,
    Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2663728.1727470216.1@warthog.procyon.org.uk>
Date: Fri, 27 Sep 2024 21:50:16 +0100
Message-ID: <2663729.1727470216@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
Cc: asmadeus@codewreck.org, dhowells@redhat.com, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Is it possible for you to turn on some tracepoints and access the traces?
Granted, you probably need to do the enablement during boot.

David

