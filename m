Return-Path: <linux-erofs+bounces-3859-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RMpvMskZTmr1DAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3859-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 11:35:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3B723C7F
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 11:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bWVOkQUn;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bWVOkQUn;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3859-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3859-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwCcR0KKKz2yft;
	Wed, 08 Jul 2026 19:35:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783503302;
	cv=none; b=EuPd6b+fuOXGwq2B4xg0qwwCR3bF/9JZ1PhNGp7UmnzXNulqEnCPaw1YV6+5BxM0otwJx0q+Jlv0+HvFh/0AlwuJKnA0fCs6gGkBvHLkyypT6RiQXUo1nJxXN/0ULfmO8KCN3cNyjQzGfhO8QLEHlWJJiA4exXSj+ttDPKoot06bTxvIn71SOZCcObLr8pSHjhX0lHS4Ff9Eq0CxJdo3lkWMHe/chKrVav4+bMq6AZ3bifLo4Wj15UisHRM+EK68NpGJ3PIWi/gufKJskaaCqLwRdCDTZKA0CNIOzgyc02D6ibxmV6SVV441vQZayTDLWAyF19bqvZcKFeAEDsO9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783503302; c=relaxed/relaxed;
	bh=LSGrhlD0yn8NtGRpP/yuLz9/lKXd3YZ5anjPExUEXbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=WQR3dHXzohx+aH+//+1/nTcZgRdvE/JdkUE/yx9xW/2UlVs35COnSMXnCJLOqXorjLN3gZmsh9zG2oZ+KQn+yGhGqGtN+LbzZqN6OYCqolEnMjnAyLHT7LIIIsz9zgM3cerAjyaGnN4F1+vU/ir5qfIojIwrwU42pjgrlGCXCmZMqkmYawFnh3tPDoC4ODb+UBotS60OqjDJM5CPyTXCdwcpMmrHQ5n1AniJFI5+y2KLmcoWcIP3sDAPDEI8/HrauLxkNNMwxYyO9vcPaFhhAzUk59AjT58WiHtkeYdQUvsRldJnLDazMZKdhL78neYRGwtzSBgmfwRjHP5uNB9pjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bWVOkQUn; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bWVOkQUn; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwCcP3P5Mz2xll
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 19:34:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LSGrhlD0yn8NtGRpP/yuLz9/lKXd3YZ5anjPExUEXbM=;
	b=bWVOkQUnF9tCr9kjqf41ApASg9eGhpe73Kft6dC0ltMTKyN3GeQ9nRdmRHwm2pN9lZa43u
	9AsEoZhomMbH9pdPPEdA9YaXC/uQ37/z5rZNSs0ixFQr1MDRjD2JpoSVAecdNBfUEq6ha7
	6WuHaeo0qkW6eOyngyloFfGOH2deFAk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LSGrhlD0yn8NtGRpP/yuLz9/lKXd3YZ5anjPExUEXbM=;
	b=bWVOkQUnF9tCr9kjqf41ApASg9eGhpe73Kft6dC0ltMTKyN3GeQ9nRdmRHwm2pN9lZa43u
	9AsEoZhomMbH9pdPPEdA9YaXC/uQ37/z5rZNSs0ixFQr1MDRjD2JpoSVAecdNBfUEq6ha7
	6WuHaeo0qkW6eOyngyloFfGOH2deFAk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-1jWkn7APP-qkLQEIcXgpAg-1; Wed,
 08 Jul 2026 05:34:51 -0400
X-MC-Unique: 1jWkn7APP-qkLQEIcXgpAg-1
X-Mimecast-MFC-AGG-ID: 1jWkn7APP-qkLQEIcXgpAg_1783503290
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 391EB1956068;
	Wed,  8 Jul 2026 09:34:50 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAC481955F43;
	Wed,  8 Jul 2026 09:34:48 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 0/2] erofs: fd-based source and backing file introspection
Date: Wed,  8 Jul 2026 11:34:25 +0200
Message-ID: <20260708093446.3370200-1-gscrivan@redhat.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: GImxKb9qCB-aecL2leZxVNHYVG5-CZuIpL4TdvOky3k_1783503290
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3859-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FC3B723C7F

This series adds two features to erofs for file-backed mounts:

1. Accept a source file descriptor via fsconfig(FSCONFIG_SET_FD,
  "source", NULL, fd) as an alternative to a path string.  This is
  useful when the backing file isn't reachable by path in the caller's
  mount namespace.  For example, composefs reusing an already-mounted
  erofs image's backing file.

2. Add an EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor
  to the backing image file.  This allows userspace to retrieve the
  backing file from an existing erofs mount without needing to know or
  parse the original source path.

Giuseppe Scrivano (2):
  erofs: accept source file descriptor via fsconfig
  erofs: add ioctl to retrieve the backing source file descriptor

 fs/erofs/inode.c           | 25 +++++++++++++++++++++++++
 fs/erofs/super.c           | 36 +++++++++++++++++++++++++-----------
 include/uapi/linux/erofs.h |  9 +++++++++
 3 files changed, 59 insertions(+), 11 deletions(-)
 create mode 100644 include/uapi/linux/erofs.h

--
2.55.0


