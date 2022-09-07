Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBCB5B0630
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Sep 2022 16:13:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MN44C35PHz3bk9
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Sep 2022 00:13:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.helo=dal210.hawkhost.com (client-ip=198.252.105.24; helo=dal210.hawkhost.com; envelope-from=<>; receiver=<UNKNOWN>)
X-Greylist: delayed 5052 seconds by postgrey-1.36 at boromir; Thu, 08 Sep 2022 00:13:44 AEST
Received: from dal210.hawkhost.com (dal210.hawkhost.com [198.252.105.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MN4482ZZZz2yxG
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Sep 2022 00:13:44 +1000 (AEST)
Received: from mailnull by dal210.hawkhost.com with local (Exim 4.95)
	id 1oVuUi-003Aee-A2
	for linux-erofs@lists.ozlabs.org;
	Wed, 07 Sep 2022 07:49:28 -0500
X-Failed-Recipients: dan3255@gmail.com
Auto-Submitted: auto-replied
From: Mail Delivery System <Mailer-Daemon@dal210.hawkhost.com>
To: linux-erofs@lists.ozlabs.org
References: <eb0c8064-a9a0-403d-904f-e1a2ae2e68e9@lists.ozlabs.org>
Content-Type: multipart/report; report-type=delivery-status; boundary=1662554968-eximdsn-685503588
MIME-Version: 1.0
Subject: Mail delivery failed: returning message to sender
Message-Id: <E1oVuUi-003Aee-A2@dal210.hawkhost.com>
Date: Wed, 07 Sep 2022 07:49:28 -0500
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - dal210.hawkhost.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - 
X-Get-Message-Sender-Via: dal210.hawkhost.com: sender_ident via received_protocol == local: mailnull/primary_hostname/system user
X-Authenticated-Sender: dal210.hawkhost.com: mailnull
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--1662554968-eximdsn-685503588
Content-type: text/plain; charset=us-ascii

This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  dan3255@gmail.com
    (generated from marketing@artisankegcleaner.com)
    host se001.arandomserver.com [198.252.100.64]
    SMTP error from remote mail server after end of data:
    550 High probability of spam

--1662554968-eximdsn-685503588
Content-type: message/delivery-status

Reporting-MTA: dns; dal210.hawkhost.com

Action: failed
Final-Recipient: rfc822;marketing@artisankegcleaner.com
Status: 5.0.0
Remote-MTA: dns; se001.arandomserver.com
Diagnostic-Code: smtp; 550 High probability of spam

--1662554968-eximdsn-685503588
Content-type: text/rfc822-headers

Return-path: <linux-erofs@lists.ozlabs.org>
Received: from [115.148.43.40] (port=34712 helo=lists.ozlabs.org)
	by dal210.hawkhost.com with esmtp (Exim 4.95)
	(envelope-from <linux-erofs@lists.ozlabs.org>)
	id 1oVuUa-0039sv-GZ
	for marketing@artisankegcleaner.com;
	Wed, 07 Sep 2022 07:49:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.2.2
From: "U787Q55" <linux-erofs@lists.ozlabs.org>
To: "marketing" <marketing@artisankegcleaner.com>
Content-Type: multipart/mixed; charset=UTF-8; boundary="------------FDBF196A987FB8FF37C1BB03"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Date: Wed, 7 Sep 2022 20:49:24 +0800
Message-Id: <eb0c8064-a9a0-403d-904f-e1a2ae2e68e9@lists.ozlabs.org>
X-Mailer: Thunderbird/68.2.2
X-Spam-Status: Yes, score=13.2
X-Spam-Score: 132
X-Spam-Bar: +++++++++++++
X-Spam-Report: Spam detection software, running on the system "dal210.hawkhost.com",
 has identified this incoming email as possible spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 root\@localhost for details.
 Content preview:  УԩлюЧӖ 湖南株洲一官员多次接受私企安排打高尔夫已被双开12:18四川泸定6.8级地震已造成65人遇难11:53国
    
 Content analysis details:   (13.2 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  1.0 BAYES_999              BODY: Bayes spam probability is 99.9 to 100%
                             [score: 1.0000]
  5.0 BAYES_99               BODY: Bayes spam probability is 99 to 100%
                             [score: 1.0000]
  0.5 JMQ_SPF_NEUTRAL        ASKDNS: SPF set to ?all
 [lists.ozlabs.org TXT:v=spf1 include:_spf.lists.ozlabs.org include:_spf.ozlabs.org ?all]
  0.0 RCVD_IN_ZEN_BLOCKED_OPENDNS RBL: ADMINISTRATOR NOTICE: The query
                              to zen.spamhaus.org was blocked due to
                             usage of an open resolver. See
                             https://www.spamhaus.org/returnc/pub/
                             [115.148.43.40 listed in zen.spamhaus.org]
  0.0 HTML_MESSAGE           BODY: HTML included in message
  0.1 MIME_HTML_ONLY         BODY: Message only has text/html MIME parts
  1.2 HTML_IMAGE_ONLY_04     BODY: HTML: images with 0-400 bytes of words
  0.8 MPART_ALT_DIFF         BODY: HTML and text parts are different
  0.0 T_OBFU_JPG_ATTACH      BODY: JPG attachment with generic MIME type
  1.8 PYZOR_CHECK            Listed in Pyzor
                             (https://pyzor.readthedocs.io/en/latest/)
  0.0 KAM_DMARC_STATUS       Test Rule for DKIM or SPF Failure with Strict
                             Alignment
  0.4 HTML_MIME_NO_HTML_TAG  HTML-only message, but there is no HTML
                             tag
  2.0 RDNS_NONE              Delivered to internal network by a host with no rDNS
 -0.0 T_SCC_BODY_TEXT_LINE   No description available.
  0.3 FSL_BULK_SIG           Bulk signature with no Unsubscribe
  0.2 TVD_SPACE_RATIO_MINFP  Space ratio (vertical text obfuscation?)
  0.0 T_REMOTE_IMAGE         Message contains an external image
X-Spam-Flag: YES
Subject:  ***SPAM*** 
 =?UTF-8?B?5LyY5YyW6JCl6ZSALS0t5oyJ5pWI5p6c6K6h6LS567+u65Ge7JKT7J697IWb?=
X-Exim-DSN-Information: Due to administrative limits only headers are returned


--1662554968-eximdsn-685503588--
