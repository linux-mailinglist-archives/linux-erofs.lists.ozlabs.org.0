Return-Path: <linux-erofs+bounces-3396-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH4WN2ykAWpKhAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3396-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 11:42:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C2450B233
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 11:42:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDZWF06Qtz2xlh;
	Mon, 11 May 2026 19:42:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778492520;
	cv=none; b=j5aHviIfmbJ15TkgapsCRvi87gklOBQOsBZJWRBTsWPrbMqZAulJqZJtw+P7N6GIKkgGoJ2xUiPArbu6EjFPESdqEE8JHkhPANH9Cr+gJNUQ61QdtzuAQcvKaWWGO0QuxZnhNjSzhAnpKO/JutSIPjasc50hIPiXQdqF80pSsy5kFTY3Roba80qyJbrayDo92/T0we04q/Eno9aEYWAy5crVzdkL0wzHnzi5lZ4iw5Dou4UxSgYQrLfNXXMLzOodldG95FJ1yWXBhp7K/R2pcLQ315CT2pCyJN/zT+MQnc9+p/E1mtGCHi2awroWcuX1pqm9klVdWmc6t4dukUTcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778492520; c=relaxed/relaxed;
	bh=UwhxSTUg/2PfbitXd6APW3F1bEy+stqNbYlvVOstu6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cf+1XG/LeQ4II3AZWYMAEnmvHDcmqMIHrBpBgjXuCzFVnKjtRZ9BruavvUb9/r7rZB+IaaalMD4bj/9kg6qWl8ky6tze3yvrLLdg/9olvEN1pykg3HeuMMDldYJ1D6aKZ/K8+vU5na5Owsr07WYS2a6P+062zYHyFXdKxes3VM02iE3ZaYrQOpq0IB5oCmd1mf7LzzVkrse+bCvMh2PQt5kjxEuMXjPqpWoCUQc0mx/km9axBq9Evf5xpcPzyu2GP4wv/1AqC3m4mSj5qfZYNYi3RqNV8UIn9UYiZ7BQ+tio9zzSnUEVdPndUsmIBcqrn0BiIDkICNVaM0g+1YjqqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2VXuo3Ds; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=joaomarcos.costa@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2VXuo3Ds;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=joaomarcos.costa@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 558 seconds by postgrey-1.37 at boromir; Mon, 11 May 2026 19:41:59 AEST
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDZWC2ctZz2xl6
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 May 2026 19:41:57 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8A52E4E42BCB;
	Mon, 11 May 2026 09:32:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6018D60646;
	Mon, 11 May 2026 09:32:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CB7C11AE870A;
	Mon, 11 May 2026 11:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778491954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=UwhxSTUg/2PfbitXd6APW3F1bEy+stqNbYlvVOstu6o=;
	b=2VXuo3DsQHOJ2oSar0HSVqdAe/40yNoXlniVeVxAqTAg/FLXjIW28KStY2ubhPu4DfUoj5
	PZaxCSwmDnVx6NwFuapPIhhHwFEUHT2VpgOdnCZetA3RSSy90B0Wl31v1Iu7dKzCDy15zL
	tepZ0i30Tlm9uvwhzUfpmv8t+QRsR+AUJ7JxCUrxflLefBhoCBuTwMUvlN44mbb9MBLOnx
	NLIzSpLnQm1RLDH/ZafxhyxeESvwzjblyA6tMD5ATaztuKnMgB799YkYCXbUpapAig0Wrh
	8UrKVG6CWWQqpWDAsDtaUVdNWYi6cJn8PL4fbOxom3jb+wxN4ryzM3CZDX67rA==
Message-ID: <358e2645-1f64-4de8-8377-0177645e9ccd@bootlin.com>
Date: Mon, 11 May 2026 11:32:31 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] test: fs: Use shared generate_file from utils
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org
References: <20260511085857.3933053-1-aristo.chen@canonical.com>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260511085857.3933053-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 08C2450B233
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,konsulko.com,bootlin.com,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3396-lists,linux-erofs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aristo.chen@canonical.com,m:u-boot@lists.denx.de,m:jnhuang95@gmail.com,m:trini@konsulko.com,m:richard.genoud@bootlin.com,m:thomas.petazzoni@bootlin.com,m:miquel.raynal@bootlin.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[joaomarcos.costa@bootlin.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joaomarcos.costa@bootlin.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,canonical.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

Hello,

On 5/11/26 10:58, Aristo Chen wrote:
> test_fs/test_erofs.py and test_fs/test_squashfs/sqfs_common.py both
> defined a generate_file() helper that writes a file of a given size
> filled with 'x'. The two functions were functionally identical and
> differed only in parameter names and docstrings.
> 
> Move the helper into the existing test/py/utils.py module, which is
> the established home for generic test utilities (md5sum_file,
> PersistentRandomFile, attempt_to_open_file). Update both call sites
> to use it.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   test/py/tests/test_fs/test_erofs.py           | 16 ++++----------
>   .../test_fs/test_squashfs/sqfs_common.py      | 22 +++++--------------
>   test/py/utils.py                              | 13 +++++++++++
>   3 files changed, 22 insertions(+), 29 deletions(-)
(...)

Thanks for the patch!

Reviewed-by: joaomarcos.costa@bootlin.com
-- 
Best regards,
João Marcos Costa

