Return-Path: <linux-erofs+bounces-3251-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /6toHHvl12n8UQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3251-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 19:44:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222B3CE404
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 19:44:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs6kb0pbkz2yT0;
	Fri, 10 Apr 2026 03:44:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775756663;
	cv=pass; b=QQKzbixtQbMcSoKa/hdFdjGbP/7AP4umjkBfoNWCUTK6qqISlk0b47jySPaRJFBcv0KxAK9cYjP+BDZxg/Vfgcr7PgQXhKj+D3GGq0kEfqsK46U91AV/+1GxHiQRXQur4AnZivvWGFmrFisWTums0YBdZf9APICuYya4AGO8oHO+Yid0cYd+ZIGHgJAFZHjmwYEdQkV6GDKs6scyYLhD/BQ9G6e2mCMa3iZL86vCfk4yd+5C+UKNujFSUK4xkrITwqMb+3kDlZo/Qx6xqKceJqArLnY1xzyRPnLuWz3/0cEHjSkDGBrhIly16McGmzs4lj7mixMBU3W+2kRIHiDd1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775756663; c=relaxed/relaxed;
	bh=ts1cjdurJ15cIR9l0rHXHWt+HIAJntr8K2wXs1MCGvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etWvpiXzAblK6Og/ytVKyIsu0ENSe05pK/CL2WxLbWawaTRvxOyb/+v7FwuN/okPzc03D9rIBwj1qKn8A8Hgbjd4UgGvKQdhZvIo84BW+5erI9IIf73x+gshwssmfRRIK8WV/CkcjUDC3NVhbmJWt8rqVtVWgHQ9gCR8JGI7nrssYtaZb05Ahk6dflZcq/NPQyZ+gXgVAQH51MB2VOXN6GuYLg/73yIF/hugpnJOzq7BFTQJnqDhRdfgtCjjELntF1o5+1012ZAhw3GH+IWpdXNxtJp1Uep97x0c5aKrIalkr16cn+mJ7/UmDBZtr+1lczJgJelUDjjIWtXQm+2Zdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=aUsz1gT7; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=aUsz1gT7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs6kY6XZmz2xpn
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 03:44:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1775756657; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=C1HXKFs2MpbkWsp9CoOD/7mqyRv32tmMj1cuYC9ovgmAH/4hHHI6d2PwEKdoF9TPzKTBjuQIm4IePjv+qh8ZQxF9rLIu/NVjAadnRrfUXvcxmwCrjbPZEmMwQYB2Orq8XK8Ln9hZyVRFYt+EpG4thdKJPZ/ckFOjM9xCCgPiQpc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1775756657; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ts1cjdurJ15cIR9l0rHXHWt+HIAJntr8K2wXs1MCGvI=; 
	b=RzBYag9/SENjqcRV57EtZ33NJG4QNbPCVCyTHKBWnbijI/j+/8jjkcpEoWFPi22SxfIYLMk6LdNzrQAYds9UzXsqdTZtFyIiWDmuKf1IxmLxJFTHY29NPkNUI1OiMsSzhJ18ybL5ou/2Q5c8NtS3D+q1cqPwF36H5FtyZLlFhxo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775756657;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ts1cjdurJ15cIR9l0rHXHWt+HIAJntr8K2wXs1MCGvI=;
	b=aUsz1gT7oGC2igS3J8/K720plm9PQUd+1FlT+c/OyOK4ObuL+rpuRt4WlR6x+O+l
	/VbS3pWpxvik8FeWMZXy9PnTp6lDKH2p2IZp5KeyEN9MmkZYLtEPPrtv1VC9+Hp2TLo
	UIkPpfhTmVFWIn2UR6rC8XYeULzDBIQvig7nrjpE=
Received: by mx.zoho.in with SMTPS id 1775756655857437.2961180662503;
	Thu, 9 Apr 2026 23:14:15 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: lib: fix packed xattr prefix seek
Date: Thu,  9 Apr 2026 17:44:15 +0000
Message-ID: <20260409174415.93704-1-ch@vnsh.in>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3251-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[vnsh.in:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8222B3CE404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_xattr_flush_name_prefixes() records the current packed file
offset, writes xattr prefixes with erofs_io_pwrite(), and then seeks
back to the new absolute end position.

Use SEEK_SET for that final lseek(). SEEK_CUR adds the tracked offset
to the unchanged file position and can leave the packed file offset too
far forward.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 565070a..9247004 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -946,7 +946,7 @@ int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain)
 		erofs_bdrop(bh, false);
 	} else {
 		DBG_BUGON(bmgr);
-		if (lseek(vf->fd, offset, SEEK_CUR) < 0)
+		if (lseek(vf->fd, offset, SEEK_SET) < 0)
 			return -errno;
 	}
 	erofs_sb_set_xattr_prefixes(sbi);
-- 
2.43.0


