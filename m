Return-Path: <linux-erofs+bounces-1156-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88165BB2CD7
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Oct 2025 10:13:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccl1M1vvKz30NF;
	Thu,  2 Oct 2025 18:13:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759392823;
	cv=none; b=Xi3O33J5iwiLpc5FbXeo0lc2oBEmaM9JoU8ydaZ2yB0SCp4ZpzkBLjPSpn30hQAF5Dlvw+EhSKxeNbKq2ExOnclEXh6PEgaZWM53pNMhG7sG2YhRPe0Y+a9cEVyhHgPWfdHr2E8p3uQBb40CP4hTbmwJty293lSROJRND2OlzCKKAITr/wt5gEV+TVYRj1cp1GmsVpJBVyshaJylp5kwpzCVO9qKmKHfgNk0YZNGPJwpCFiWWlSDenYXFnWR0DLsO3WMr2VkPtwPVeZ02rQ0fSNy1x25yDhfH8tVKTOF3thSpH5o9XOG3nssmfyk7Ykg0M+mPwPXgbUVaOtfHssu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759392823; c=relaxed/relaxed;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3PVSYkFr0gshxm7vLZknrVDZgb+7CGZYTEpkyraU0eXKUIepnJ2Qw9T+ZBA3lMdgqUDj2OFyziB0/o/jEdx5J32mdKF/Xb8+4+OTWzts0fGYcLI2ue4E4gpNXY6N+yunD9LcZvlG4LXjx8DCfCGD8bzYNtW5PUdhHQbXwVvZu2w57uY+/jJ99or/m9foWUAfPdm6BS+kKufz+OvJXAwYogDQNkFBZ/VNAVdx+SrIvzzhe6rGK/F8G/8uv0I5Ni5pF/t4Oy3vG1smceKVWxFaoF2XcQxHUXSD/t+eUljQOHV6EDxY5paKxP5TE7kfYXeK8pTdlHZ58LeAX3iJ5JW9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C9PS/Xqp; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wb635R2e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C9PS/Xqp; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wb635R2e; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C9PS/Xqp;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wb635R2e;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C9PS/Xqp;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wb635R2e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
X-Greylist: delayed 337 seconds by postgrey-1.37 at boromir; Thu, 02 Oct 2025 18:13:41 AEST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccl1K4cHFz3069
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Oct 2025 18:13:40 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC67B1FB58;
	Thu,  2 Oct 2025 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759392817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	b=C9PS/XqpRwB0UxviuEwDxPbrPJJwJ4LCFEIURbjaA+NpgyqTtGz+hwws4INrZOffGztQLo
	RkOxRbE8eXXsfP6k95iAXuDJ/jcYphscDhGoO4ln9Pxd2hNG6b2w6x4sOZtqjHhzzZ4yWa
	QJPDA21AAPTieOG4oNDxUAwF5mgXlRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759392817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	b=wb635R2ev6hLEuRvM3mt31zFl9Ysi0h8ox5XgXI+7PDNC7XS+Z+T3UKqB700P93cyUKPEI
	82NFCC28TIfDXIDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="C9PS/Xqp";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wb635R2e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759392817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	b=C9PS/XqpRwB0UxviuEwDxPbrPJJwJ4LCFEIURbjaA+NpgyqTtGz+hwws4INrZOffGztQLo
	RkOxRbE8eXXsfP6k95iAXuDJ/jcYphscDhGoO4ln9Pxd2hNG6b2w6x4sOZtqjHhzzZ4yWa
	QJPDA21AAPTieOG4oNDxUAwF5mgXlRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759392817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruoQlOdDmzp5MY4S54nO3umGAxEqdmJBP4WXf9I5T3Q=;
	b=wb635R2ev6hLEuRvM3mt31zFl9Ysi0h8ox5XgXI+7PDNC7XS+Z+T3UKqB700P93cyUKPEI
	82NFCC28TIfDXIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2CB21395B;
	Thu,  2 Oct 2025 08:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C2OkKzE03mhoUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Oct 2025 08:13:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C2DBA0A56; Thu,  2 Oct 2025 10:13:37 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	<linux-fsdevel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	Jan Kara <jack@suse.cz>,
	syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com
Subject: [PATCH] dax: fix assertion in dax_iomap_rw()
Date: Thu,  2 Oct 2025 10:13:12 +0200
Message-ID: <20251002081311.10488-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=jack@suse.cz; h=from:subject; bh=UsMqyOIhr8WHIm6v1/phOHfCF4/wORmA8WhPGDaHvQU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBo3jQXQ9++U/Immj1t7Q2t9La2rvw9BDT7qKvX4 aakZ8ucOJGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaN40FwAKCRCcnaoHP2RA 2Z6yCADWOVDY5abLZ6s85kA8oXAY0ON0EFcqsNzUAOxR5+syzjr3MERold2c80b5sRUH/4g7CBV yWqyD8/D+Raml1imo1K7wJcQp94t2xlCRCutADrHW6vmo8Kk7sDNg79sBomyqZvo3FazOzpesvR 5TUe6esMFh2DCYomiSV9UuYL0rEl+q8HyxZ5yar89IpQd89e5btjoC4XZJQJ2vz4mnH3+hX/7R7 XNbs5czy365hJPGwBnr25CN87vcdz5A4ua5c8jhoXwpywav0rpSLGaMryatmtxFlBa8UxoKtzPf Z7YUk6NeBPEmr9VR7U4kMcImAMs7bj9/lPbQtQo7deOOxTLl
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[47680984f2d4969027ea];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Rspamd-Queue-Id: BC67B1FB58
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

dax_iomap_rw() asserts that inode lock is held when reading from it. The
assert triggers on erofs as it indeed doesn't hold any locks in this
case - naturally because there's nothing to race against when the
filesystem is read-only. Check the locking only if the filesystem is
actually writeable.

Reported-by: syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 20ecf652c129..187f8c325744 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1752,7 +1752,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iov_iter_rw(iter) == WRITE) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
-	} else {
+	} else if (!IS_RDONLY(iomi.inode)) {
 		lockdep_assert_held(&iomi.inode->i_rwsem);
 	}
 
-- 
2.51.0


