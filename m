Return-Path: <linux-erofs+bounces-2722-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KuwUHniot2lSUAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2722-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 07:51:36 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C849F295467
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 07:51:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ5NN0qxfz2xln;
	Mon, 16 Mar 2026 17:51:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773643892;
	cv=none; b=BiT+OuJohfM+fdA6GzyxuJhQ6E1vHPuXvzDDOkIxSqNHwiQRwJmUzJ0uPbcDTI1e9OJfOYQYlwL+znd3AH9PBkY5BrqCAqB4Rm6mu0V3i23ZagDbVtHDTDSZbSFWXON1Yg7VyU/FxZY5/jKWKtulfR3Wu1KvK7AYScIzezfggQaSaZSfeJ5bNOHc4LNC/BHw6tSInhb1fVeMxfKtc+KVp6Ss+Bd8NlZKTeXujNe08ToSHczmQGsOvR+La8MTw0JdAn36Kwm+NPWIcol/Nb1HPKpZMjGIVQFDeiOEhTzf2qx72PSwpzK75rDrvKlbiFwTmlRBjKJyqmm8i9WXXK0eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773643892; c=relaxed/relaxed;
	bh=3thA7nSZIx1aY1rAj+DcvsZ/4l7CDlw0lD8sNr3vmP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bs37xESKz+5wqE/axYlxdzC5fkwK8JHcPF+FuP/Aqk/4SoZ/ubcteNRz9OdBa+JpoUbbyqhRrGE1dg85+at5UuMGMcJyIzqQs4qar/yzmoF/eQf7NOIk7eCJxn48Iwj50gEzJBNgaX0NYb+X+8rOV+45+2k5N8PDGTWGQzJlc/K2asaPedOWg7QKLH+I+JOdws55yJxpYy1h0l5gdXjCFOG7zScB88GAqlFN/wNlh3h7S7fwsrrmmeumpVAxCKD0snZ80SEFO2f0DItBtj/f6lleWQdKnTAGSt04BBrbPzbNREM79QyzE8VY0I+7v+J1lXY/yvJM2SbQvIrTZSmxcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QTJGFllv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QTJGFllv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ5NM08yKz2xS5
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 17:51:30 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c7382963b67so146990a12.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773643888; x=1774248688; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3thA7nSZIx1aY1rAj+DcvsZ/4l7CDlw0lD8sNr3vmP0=;
        b=QTJGFllv+yy7IfXSf6lRQjBdGrrsco4gqj+c+SNQi/rlKwi4IZL1OR2ijh25WF+Iv/
         tizGEgkDcbTNgX2iOjhCtdP6HIO5mjzWpV6fAgxtz13ZGuvfj2qNzFE9fcSdCCpldyQv
         QpJlU3nGmj5U2mTc+gFblVRgIuYhnEYwa3kcQctEdrdrpD/b52p/oYmyM6S1Jz83X39D
         sKV2o36qBkmMFJMdJXXCgLdDGtyjk7QXIXryXB47BhkfI5efbd5Qh9O31aYKrxn9hioJ
         vSQ9dCPGExjYR6CWPSSjZ01ZWBl5KSYHrLiAFUAzRTrDETL+mwdQLLKNg8NDMqxfplHw
         fOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773643888; x=1774248688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3thA7nSZIx1aY1rAj+DcvsZ/4l7CDlw0lD8sNr3vmP0=;
        b=MgNd0rQbQ9h3poAgjInjLX9A4rNADONPrrhb1fD9C+xDKW75gzKd/Ej53I7+ci+ubI
         xUV2B3nivOXnlnkaIPiNSGhMRZm4TAiB+32LvUYntXLr9VZTlZAX5KE0jd67xK9WsK8i
         QKJY8s3IjY5u30B9cQzsxHWkadWX16vjObG8X5Y3gadMQjjgblOrM0CuVtit2+DLE4xs
         eJr1MyV6a3CNDVQcbyXGp+OYmiHdyo858y13oo0Uk9Tjdix1BVJkRYTumZ2Us+Jw7MBK
         6sFYX2D5ouRrtSoNfzfrdbAh/JjxRL6neMXhgMCI0NjnILldQ8CSR4z/6qTVmMB49S9x
         lOrQ==
X-Gm-Message-State: AOJu0YzPcNIGmK44bAqp8ERjVNrxma+dT7d4FYFEwv74Jtz4ZFej+auN
	mqeExCi8U0Bvsfl0rzIf2Lw/WizLQnft3B6OFUUbYrSAI7cGVaB+3O7ZPwgrk3EV
X-Gm-Gg: ATEYQzyXLCt9tyyPHfH1y/M/HtvpwxSCBEY9k+3DH024wHnMkrkSDjVdp5kwuqDVkxu
	P+EhkVSFsQwgtytnvdsGQS2Db230BWxmI3gqFO6qIFiSMgSqZtaDmXIzLvKIu/tYaqtT3OqjboJ
	mXFkrH3Is+g1fijq1VakKNvJ0y7yOch0rHyQFutYBpHYxKyBXc1KPqowwMrHxBeXzb2kNnLucDe
	EfzqckIwp3C/Fy71tPzPZAxZSYSdWoX+Np2ub9a4qoiA7Jg8eKewOpcrSWkJbnpr3Dw+bZbn4jv
	2VVtZ4+XayvjXzKABytxPbjRf6FgOGbrwOpNGa9WhkpLdncT8SQTH5anBda0UxCt36L/kWHcxO5
	DI4gG8ZJQ4/3lXz2hyKoXUrMru2fS2SDO6wtTV4ponpjBP+PZUqMKZZlrECnTxLPIxVQESxTI0a
	MrB7NGuG1e04Y+D7eIU0ZO59jiw4DU2CZHEitOn9WBgdOI+CYUQCaaMXpvrWHILgem10URR1UJe
	mywchArwgNW9Wj0zt5Ekytz0j8eTgOE33AjN/3POiGhySQ=
X-Received: by 2002:a05:6a21:6d9f:b0:394:1532:6619 with SMTP id adf61e73a8af0-398ec9fdd33mr6872336637.1.1773643888494;
        Sun, 15 Mar 2026 23:51:28 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73fc1774dfsm4218601a12.1.2026.03.15.23.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 23:51:28 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v2 0/2] erofs-utils: lib/tar: fix PAX header parsing issues
Date: Mon, 16 Mar 2026 06:51:17 +0000
Message-ID: <20260316065119.21726-1-singhutkal015@gmail.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2722-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C849F295467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These two patches fix input validation bugs in the PAX extended
header parser in lib/tar.c that can trigger crashes on malformed
or crafted tar archives.

Patch 1 skips PAX entries with empty path= value to avoid
out-of-bounds access on zero-length strings.

Patch 2 rejects negative size= values to prevent heap corruption
from incorrect allocation sizes in subsequent operations.

Changes in v2:
  - Fix mixed indentation in patch 2/2 (use tabs, not spaces)

Utkal Singh (2):
  erofs-utils: lib/tar: skip PAX entries with empty path
  erofs-utils: lib/tar: reject negative size= value in PAX header

 lib/tar.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.43.0


