Return-Path: <linux-erofs+bounces-3865-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J2ChDtlqTmo1MQIAu9opvQ
	(envelope-from <linux-erofs+bounces-3865-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 17:20:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6ED727E93
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 17:20:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LpGlg+O8;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=jS1f2tev;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3865-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3865-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwMHT2bppz2xpn;
	Thu, 09 Jul 2026 01:20:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783524053;
	cv=none; b=ZmemQRx8rsMv5Ue5lE2iGnkT7+eGingsyGe0k+6k7gubSV+alCck+GzdrgQjMkyMYnrBMr2YwlkWcF9MjODD6JVljNALHdZ/JAjwMMM+aVKmxB975tOay9ZVDXyIWzVkWLpcsm0aNXUZ5uFPEQgs598ORROQuWsJsCEJxpdVWchYT+7z8lhMwjNWh48XQBZiAMbx8Tzubhjos46TOmSIdAiyEomeeRydcxUtiNf16l9pzHAmtHyhWMiaD7jUN7l31DrfOmeHr1Cnop61m2egBA0aSRrwpyTPxZsnqCWWvwbhoeNt/ynEiXAoJ9fS+xxPwWmcjuEWiKrdKkF3/q11lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783524053; c=relaxed/relaxed;
	bh=HURSYDykY8k1L24raC+Jwe3BrV0VQrzse+Bwrd/cOZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H5GjIqnVBgAm2oEMpTex6zGlqUDfUA9v4y7RLDmsVZeHkRe/APsspJHHbms+fgklqBmmjNbF425ScCbBRm2NIqdaZqshq9Lx8Gp3jqIxrtoWpkrWYPK3TEDeMPB3bx/1nKm2fPTUJAclQN7SAWAqtJjv1o9vDK/JKvgZjL7dqhYMc5FHpVrbCfZjh6TeAzdZYNFXWJvYdpDMigQEQfq358BUFbC4xo5R36oGRsYagMOlIrRVeotPacgIWb5cefBfflwE4pCkg3YY3e0e6fL84p45kmcQrtK0RBP+rIq7V2lGz5iCg0IlPGF7OBbfV5qt3HwCEfbGc5ptiIyEBnII5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LpGlg+O8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jS1f2tev; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMHR6ncqz2xll
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jul 2026 01:20:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783524045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HURSYDykY8k1L24raC+Jwe3BrV0VQrzse+Bwrd/cOZI=;
	b=LpGlg+O88nQ/uMrQz9UbJ/2VnF9BGOmbAPgk0Z9RE6iwdJnDKgnhsQx/NFol6Hzk12eLrJ
	coSTa2aygDqfPTMSU+eR95alYNa/AmpGFJV2RHGEaPyA/2SvHeETEAzS3gwh1Lh0KhptLi
	hqeSebF5qRuKCdvvy4XGO8sUfZphC+M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783524046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HURSYDykY8k1L24raC+Jwe3BrV0VQrzse+Bwrd/cOZI=;
	b=jS1f2tevZgnXUuaPWbaWdL9qooA/gsQnSSjBjnwYU9YhsWfsZnSlW5yh16oiqokxKd3rT6
	f203Lhl97Po7gjvOx27trWrXVp6W9TNq1F7057/jcdWDnhGWBPIigDwukVHTBvfF5Te80l
	/yP+ytPQkPBGvvZmvIQXyy2XGXiOVlw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-vDRzEdaNORW7ILXOiYMtLQ-1; Wed,
 08 Jul 2026 11:20:42 -0400
X-MC-Unique: vDRzEdaNORW7ILXOiYMtLQ-1
X-Mimecast-MFC-AGG-ID: vDRzEdaNORW7ILXOiYMtLQ_1783524042
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F1D8195604D;
	Wed,  8 Jul 2026 15:20:41 +0000 (UTC)
Received: from localhost (unknown [10.44.33.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B25A81955F7B;
	Wed,  8 Jul 2026 15:20:40 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-erofs@lists.ozlabs.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] erofs: add ioctl to retrieve the backing source
 file descriptor
In-Reply-To: <CALCETrVE0g-qKC079K4Ch=26VH6R+q1tXVU7HiN_Og9o1zzpow@mail.gmail.com>
	(Andy Lutomirski's message of "Wed, 8 Jul 2026 07:55:25 -0700")
References: <20260708093446.3370200-1-gscrivan@redhat.com>
	<20260708093446.3370200-3-gscrivan@redhat.com>
	<CALCETrVE0g-qKC079K4Ch=26VH6R+q1tXVU7HiN_Og9o1zzpow@mail.gmail.com>
Date: Wed, 08 Jul 2026 17:20:39 +0200
Message-ID: <87se5t7bjs.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
X-Mimecast-MFC-PROC-ID: N52lKwoabQDk2gIAmK-UHR-QTcBpLDL_wQvDW_mcLVc_1783524042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3865-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,amacapital.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB6ED727E93

Andy Lutomirski <luto@amacapital.net> writes:

> On Wed, Jul 8, 2026 at 2:36=E2=80=AFAM Giuseppe Scrivano <gscrivan@redhat=
.com> wrote:
>>
>> Add EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor to the
>> backing image file for file-backed erofs mounts.
>
> What=E2=80=99s the use case?

the use case is to reuse EROFS mounts across multiple composefs mounts
without needing a user space daemon to keep the fd alive.  The advantage
is that we can share the same superblock across multiple overlay mounts,
instead of limiting the sharing to the same backing file.

> In any event, this seems to have potential security and API-oddity implic=
ations.
>
> 1. That capable(CAP_SYS_ADMIN) seems critical =E2=80=94 otherwise a task =
that
> is admin in a userns can get an fd to a backing file *outside* its
> container or to an otherwise inaccessible file.  It at least needs a
> comment IMO.

thanks, I'll add that.

> 2.  This series appears to fully round-trip the struct file. That
> means that f_cred and mode are preserved. This seems strange and may
> have all kinds of accidental effects. For mode in parallel, if the
> program that mounts the backing store opened it for write, then this
> API gives a writable fd, which seems like an odd choice for a
> filesystem that literally has read only in the name.
> The OVL variant has these issues to a lesser extent due to the fact
> that it returns an O_PATH fd instead of an actual open file.

I didn't think much of the file mode as I assumed requiring
CAP_SYS_ADMIN was enough.  I'll change the file mode to O_RDONLY and use
current_cred() to open it.  Would that be enough?

Thanks,
Giuseppe


